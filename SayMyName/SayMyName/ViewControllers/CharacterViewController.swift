//
//  CharacterViewController.swift
//  SayMyName
//
//  Created by Emin Saygı on 25.11.2022.
//

import UIKit

class CharacterViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var portrayedLabel: UILabel!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.layer.cornerRadius = 15
        nameLabel.text = "Name: \(character?.name ?? "name not found")"
        statusLabel.text = "Status: \(character?.status?.rawValue ?? "status not found")"
        nicknameLabel.text = "Nikcname: \(character?.nickname ?? "nickname not found")"
        portrayedLabel.text = "Actor: \(character?.portrayed ?? "actor not found")"
        
        NetworkManager.shared.fetchImage(from: character?.img ?? "") { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.photoImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}


