//
//  MainCategoryModel.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 02/04/2025.
//

import Foundation

class MainCategoryModel {    
    var id: Int = 0
    var name: String = ""
    var subcategories: [SubCategoryModel]?
    var repo: AppRepository?
    
    init(repo: AppRepository? = nil) {
        self.repo = repo ?? MockRepository()
    }
    
    @discardableResult
    func getSubCategories() async -> String? {
        let result = await repo?.getSubCategories(catId: self.id)
        switch result {
        case .success(let subcategories):
            self.subcategories = subcategories
            return nil
        case .failure(let error):
            return "failure fetching getsubcategories"
        case .none:
            return "failure no init repo"
        }
    }
}
