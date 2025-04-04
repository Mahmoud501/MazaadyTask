//
//  DropDownPopup+SearchDelegate.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 04/04/2025.
//

import Foundation
import UIKit

extension DropDownPopup: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.replacingOccurrences(of: " ", with: "") == "" {
            filteredData = data
        }else {
            filteredData = data.filter { item in
                if item.name?.contains(searchText) == true {
                    return true
                }
                return false
            }
        }
        tableView.reloadData()
    }
    
}
