//
//  GameDetailCell.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import UIKit

class GameDetailCell: UITableViewCell {

    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(developer: String, title: String, release: String, rating: Double, playCount: Int, description: String) {
        developerLabel.text = developer
        titleLabel.text = title
        releaseLabel.text = release
        ratingLabel.text = "\(rating)"
        playCountLabel.text = "\(playCount) played"
        
        descriptionTextView.attributedText = description.html2AttributedString
    }

    
}
