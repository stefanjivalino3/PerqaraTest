//
//  SearchBarCell.swift
//  PerqaraTest
//
//  Created by Stefan Jivalino on 23/02/23.
//

import UIKit

class SearchBarCell: UITableViewCell {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var didChangeSearchValue: (() -> ())?
    var didSearchLessThenThree: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchBar.delegate = self
        
    }
    
}

extension SearchBarCell: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count ?? 0 >= 3 {
            didChangeSearchValue?()
        } else {
            didSearchLessThenThree?()
        }
    }
}
    
