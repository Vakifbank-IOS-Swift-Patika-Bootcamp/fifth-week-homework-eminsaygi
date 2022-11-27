//
//  EpisodeViewCell.swift
//  SayMyName
//
//  Created by Emin Saygı on 26.11.2022.
//

import UIKit

class EpisodeViewCell: UITableViewCell {

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
