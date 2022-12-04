//
//  NotesEditViewController.swift
//  SayMyName
//
//  Created by Emin Saygı on 3.12.2022.
//

import UIKit
import CoreData

class NotesEditViewController: UIViewController {
    
      let stackView = UIStackView()
      let notesTextField = UITextField()
      let seasonTextField = UITextField()
      let episodeTextField = UITextField()
      let saveButton = UIButton()
    
    var notes = ""
    var episode = ""
    var season = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.axis = .vertical
                stackView.distribution = .fillEqually
                stackView.alignment = .fill
                stackView.spacing = 10
                stackView.translatesAutoresizingMaskIntoConstraints = false
                
                notesTextField.placeholder = "Enter text here"
                notesTextField.borderStyle = .roundedRect
                notesTextField.translatesAutoresizingMaskIntoConstraints = false
                
                seasonTextField.placeholder = "Enter text here"
                seasonTextField.borderStyle = .roundedRect
                seasonTextField.translatesAutoresizingMaskIntoConstraints = false
                
                episodeTextField.placeholder = "Enter text here"
                episodeTextField.borderStyle = .roundedRect
                episodeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        if notesTextField.text == "" {
            notesTextField.text = notes
              }
              if seasonTextField.text == "" {
                  seasonTextField.text = season
              }
              if episodeTextField.text == "" {
                  episodeTextField.text = episode
              }
                
                saveButton.setTitle("Save", for: .normal)
                saveButton.setTitleColor(.blue, for: .normal)
                saveButton.translatesAutoresizingMaskIntoConstraints = false
                saveButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
                saveButton.backgroundColor = .lightGray
                
                stackView.addArrangedSubview(notesTextField)
                stackView.addArrangedSubview(seasonTextField)
                stackView.addArrangedSubview(episodeTextField)
                stackView.addArrangedSubview(saveButton)
                
                view.addSubview(stackView)
                
                NSLayoutConstraint.activate([
                    stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
                    stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                    stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                    stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                   
                    notesTextField.widthAnchor.constraint(equalToConstant: 200),
                    notesTextField.heightAnchor.constraint(equalToConstant: 50),
                    seasonTextField.widthAnchor.constraint(equalToConstant: 200),
                    seasonTextField.heightAnchor.constraint(equalToConstant: 50),
                    episodeTextField.widthAnchor.constraint(equalToConstant: 200),
                    episodeTextField.heightAnchor.constraint(equalToConstant: 50)
                    ])

    }
    @objc private func didTapButton(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "BBData", into: context)
        
        saveData.setValue(notesTextField.text, forKey: "note")
        saveData.setValue(seasonTextField.text, forKey: "season")
        saveData.setValue(episodeTextField.text, forKey: "episode")
        saveData.setValue(UUID(), forKey: "id")
        
        
        do {
          
                
                try context.save() // Telefonu yeniden başlatınca kaydetmeyi sağlıyor
                savedAlert(title: "Succes", message: "Congratulations. Successfully Saved")
                
            
            
        } catch {
            print("Catch: MovieDetailVC.swift : saveFavouriteButton")
            
        }
        
        // Kaydedilen bir data olduğu haberini gönderiyoruz. Bunu da newData key'i ile yapıyoruz.
        NotificationCenter.default.post(name: Notification.Name.init(rawValue: "newData"), object: nil)
        notesTextField.text = ""
        seasonTextField.text = ""
        episodeTextField.text    = ""
    }
 
    private func savedAlert(title: String, message: String) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler:  nil)
        
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
        
    }

    
}


