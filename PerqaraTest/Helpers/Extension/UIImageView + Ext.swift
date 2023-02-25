//
//  UIImageView + Ext.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 22/02/23.
//

import Kingfisher
import UIKit

extension UIImageView {
    func showImageFromUrl(url: String) {
        self.kf.setImage(with: URL(string: url))
    }
    
    
}
