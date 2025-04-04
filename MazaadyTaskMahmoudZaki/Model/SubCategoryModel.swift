//
//  SubCategoryModel.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 02/04/2025.
//

import Foundation

class SubCategoryModel {    
    var id: Int = 0
    var name: String = ""
    var properties: [PropertyModel]?
    
    var repo: AppRepository?
    
    init(repo: AppRepository? = nil) {
        self.repo = repo ?? MockRepository()
    }

    @discardableResult
    func getProperties() async -> String? {
        let result = await repo?.getProperties(subCatId: self.id)
        switch result {
        case .success(let properties):
            self.properties = properties            
            return nil
        case .failure(let error):
            return "failure fetching properites"
        case .none:
            return "failure no init repo"
        }
    }
}
