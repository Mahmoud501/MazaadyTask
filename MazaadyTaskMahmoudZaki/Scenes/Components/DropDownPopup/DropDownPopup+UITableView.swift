//
//  DropDownPopup+UITableView.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 04/04/2025.
//

import Foundation
import UIKit

extension DropDownPopup: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell()
        tableViewCell.textLabel?.text = filteredData[indexPath.row].name
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        close()
    }
    
}
