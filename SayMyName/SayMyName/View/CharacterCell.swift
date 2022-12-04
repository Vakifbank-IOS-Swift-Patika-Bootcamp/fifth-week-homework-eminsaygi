//
//  CharacterCell.swift
//  SayMyName
//
//  Created by Emin Saygı on 25.11.2022.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var originNameLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    
    func configure(with character: Character) {
        
        nameLabel.text = character.name
        originNameLabel.text = character.nickname
        birthLabel.text = character.birthday
        NetworkManager.shared.fetchImage(from: character.img ?? "") { [weak self] result in
            switch result {
                
            case .success(let imageData):
                self?.photoImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
