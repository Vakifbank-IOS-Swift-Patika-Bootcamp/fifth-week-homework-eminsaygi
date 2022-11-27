//
//  EpisodeViewController.swift
//  SayMyName
//
//  Created by Emin Saygı on 26.11.2022.
//

import UIKit
class EpisodeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 61
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EpisodeViewCell = episodeTableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeViewCell
        
        NetworkManager.shared.getQuotesData {  result in
            
            switch result {
            case .success(let data):
                
                DispatchQueue.main.async {
                    cell.episodeLabel.text = "Name: \(data[indexPath.row].title)"
                    cell.seasonLabel.text = "Season:  \(data[indexPath.row].season)"
                }
                
            case.failure(_):
                print("Catch: MovieListVC.swift : getMovieData")
            }
        }
        return cell
    }
    
    @IBOutlet weak var episodeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        episodeTableView.dataSource = self
        episodeTableView.delegate = self
       
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
       
        
    }
    



}
