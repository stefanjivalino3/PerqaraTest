//
//  EmptyViewCell.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 24/02/23.
//

import UIKit

class EmptyViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
