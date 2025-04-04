//
//  PropertyModel.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 02/04/2025.
//

import Foundation

class PropertyModel {
    var id: Int = 0
    var parent: PropertyModel?
    var name: String = ""
    var values: [PropertyValueModel]?    
    var repo: AppRepository?
    
    init(repo: AppRepository? = nil) {
        self.repo = repo ?? MockRepository()
    }
        
    @discardableResult
    func getPropertyValues(parentValueId: Int? = nil) async -> String? {
        if self.parent != nil &&  parentValueId == nil {
            return "parent value must select first"
        }        
        let result = await repo?.getPropertiesValues(proId: id, parentValueId: parentValueId)
        switch result {
        case .success(let proValues):
            self.values = proValues
            for item in values ?? [] {
                item.property = self
                item.parentProperty = self.parent
            }
            return nil
        case .failure(let error):
            return "failure fetching getsubcategories"
        case .none:
            return "failure no init repo"
        }
    }
}
