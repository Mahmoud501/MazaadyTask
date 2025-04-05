//
//  MockRepository.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 03/04/2025.
//

import Foundation

enum FactorError: Error {
    case network
    case error(String)
}

class MockRepository: AppRepository {
    
    func getCategories() async -> Result<[MainCategoryModel]?, FactorError> {
        try? await Task.sleep(nanoseconds: 1000000000)
        let cat1 = MainCategoryModel()
        cat1.id = 1
        cat1.name = "category1"
        let cat2 = MainCategoryModel()
        cat2.id = 2
        cat2.name = "category2"
        let cat3 = MainCategoryModel()
        cat3.id = 3
        cat3.name = "category3"
        return .success([cat1, cat2, cat3])
    }
    
    func getSubCategories(catId: Int) async -> Result<[SubCategoryModel]?, FactorError> {
        try? await Task.sleep(nanoseconds: 1000000000)
        let sub1 = SubCategoryModel()
        sub1.id = 1
        sub1.name = "sub1"
        let sub2 = SubCategoryModel()
        sub2.id = 2
        sub2.name = "sub2"
        let sub3 = SubCategoryModel()
        sub3.id = 3
        sub3.name = "sub3"
        let sub4 = SubCategoryModel()
        sub4.id = 4
        sub4.name = "sub4"
        return .success([sub1, sub2, sub3, sub4])
    }
    
    func getProperties(subCatId: Int) async -> Result<[PropertyModel]?, FactorError> {
        try? await Task.sleep(nanoseconds: 1000000000)
        let pro1 = PropertyModel()
        pro1.id = 1
        pro1.name = "color"
        let pro2 = PropertyModel()
        pro2.id = 2
        pro2.name = "size"
        return .success([pro1, pro2])
    }
    
    func getPropertiesValues(proId: Int, parentValueId: Int?) async -> Result<[PropertyValueModel]?, FactorError> {
        try? await Task.sleep(nanoseconds: 1000000000)
        let value1 = PropertyValueModel()
        value1.id = Int.random(in: 10000...1000000000)
        value1.value = "value" + "_" + value1.id.description
        let value2 = PropertyValueModel()
        value2.id = Int.random(in: 10000...1000000000)
        value2.value = "value" + "_" + value2.id.description
        let value3 = PropertyValueModel()
        value3.id = 0        
        return .success([value1 , value2, value3])
    }
    
}
