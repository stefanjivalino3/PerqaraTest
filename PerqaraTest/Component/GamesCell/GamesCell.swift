//
//  GamesCell.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 22/02/23.
//

import UIKit

class GamesCell: UITableViewCell {
    @IBOutlet weak var gamesImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    func setupView() {
        gamesImageView.layer.cornerRadius = 20
    }
    
    func configureCell(gamesImage: String, title: String, releaseDate: String, rating: Double) {
        titleLabel.text = title
        gamesImageView.showImageFromUrl(url: gamesImage)
        releaseDateLabel.text = "Release date \(releaseDate)"
        ratingLabel.text = "\(rating)"
        
    }
    
}
