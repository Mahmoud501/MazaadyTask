//
//  AppRepository.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 03/04/2025.
//

import Foundation

protocol AppRepository {
    func getCategories() async -> Result<[MainCategoryModel]?, FactorError>
    func getSubCategories(catId: Int) async -> Result<[SubCategoryModel]?, FactorError>
    func getProperties(subCatId: Int) async -> Result<[PropertyModel]?, FactorError>
    func getPropertiesValues(proId: Int, parentValueId: Int?) async -> Result<[PropertyValueModel]?, FactorError>
}

