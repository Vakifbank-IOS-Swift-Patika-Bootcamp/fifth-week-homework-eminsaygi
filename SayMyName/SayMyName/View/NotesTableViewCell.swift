//
//  NotesTableViewCell.swift
//  SayMyName
//
//  Created by Emin Saygı on 30.11.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
