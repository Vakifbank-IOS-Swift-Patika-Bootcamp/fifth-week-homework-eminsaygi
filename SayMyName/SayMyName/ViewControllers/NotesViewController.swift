//
//  NotesViewController.swift
//  SayMyName
//
//  Created by Emin Saygı on 30.11.2022.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    private var notesArray = [String]()
    private var episodeArray = [String]()
    private var seasonArray = [String]()
    private var idArray = [UUID]()
    
    private var notes = ""
    private var episode = ""
    private var season = ""
    private let floatingButton: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        button.backgroundColor = .systemPink
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.5
      
        button.layer.cornerRadius = 30
        return button
    }()

    @IBOutlet weak var notesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        notesTableView.dataSource = self
        notesTableView.delegate = self
        getData()

        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        // Bir gözlemci tanımladık. Haberciden gelecek verileri işleyecek.
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
        
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 160 , width: 60, height: 60)

    }
    
    @objc private func didTapButton(){
        performSegue(withIdentifier: "notesEditVC", sender: nil) // segue çalışması için gerekli metod    
    }
  

}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NotesTableViewCell = notesTableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesTableViewCell
        cell.episodeLabel.text = "Notes: \(notesArray[indexPath.row])"
        cell.seasonLabel.text = "Season: \(seasonArray[indexPath.row])"
        cell.chapterLabel.text = "Chapter: \(episodeArray[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        notes = notesArray[indexPath.row]
        episode = episodeArray[indexPath.row]
        season = seasonArray[indexPath.row]
        performSegue(withIdentifier: "notesEditVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "notesEditVC"  {
            let detailVC = segue.destination as? NotesEditViewController
            
            detailVC?.notes = notes
            detailVC?.episode = episode
            detailVC?.season = season
            
            
        }
      
    }
    
    
}



extension NotesViewController {
    
    @objc private func getData(){
        //Aynı türden verileri kaydetmemeyi sağlıyor.
        notesArray.removeAll(keepingCapacity: false)
        seasonArray.removeAll(keepingCapacity: false)
        episodeArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
       
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BBData")
        fetchRequest.returnsObjectsAsFaults = false // Büyük data verilerini okurken hız sağlıyor.
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    
                    if let notes = result.value(forKey: "note") as? String {
                        notesArray.append(notes)
                        
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        idArray.append(id)
                        
                    }

                  
                    if let season = result.value(forKey: "season") as? String {
                        seasonArray.append(season)
                        
                    }
                    if let episode = result.value(forKey: "episode") as? String {
                        episodeArray.append(episode)
                        
                    }
                    self.notesTableView.reloadData()
                }
            }
            
        } catch {
            print("Catch: FavouritesVC.swift : DataList")
            
        }
    }
}


extension NotesViewController {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BBData")
        
        let idString = idArray[indexPath.row].uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        
        fetchRequest.returnsObjectsAsFaults = false // Büyük data verilerini okurken hız sağlıyor.
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let _ = result.value(forKey: "id") as? UUID {
                    context.delete(result)
                    
                    idArray.remove(at: indexPath.row)
                    notesArray.remove(at: indexPath.row)
                    episodeArray.remove(at: indexPath.row)
                    seasonArray.remove(at: indexPath.row)
                    
                    
                    self.notesTableView.reloadData()
                    
                    do  {
                        try context.save()
                    } catch {
                        print("Catch: FavouritesVC.swift : NSManagedObject")
                    }
                    break
                }
            }
        } catch {
            print("Catch: FavouritesVC.swift : commit editingStyle")
            
        }
        
    }
}
