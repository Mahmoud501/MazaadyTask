//
//  Controller.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 04/04/2025.
//

import Foundation

class FormController {
    
    var id: Int = 0
    var categories: [MainCategoryModel]?
    var selectedMainCategory: MainCategoryModel?
    var selectedSubCategory: SubCategoryModel?
    var selectedPropertiesValues: [PropertyValueModel]?
    
    //
    
    var repo: AppRepository?
    
    init(repo: AppRepository? = nil) {
        self.repo = repo ?? MockRepository()
    }
    
    func getCategories() async -> String? {
        let result = await repo?.getCategories()
        switch result {
        case .success(let categories):            
            self.categories = categories
            return nil
        case .failure(let error):
            return "failure fetching categories"
        case .none:
            return "failure no init repo"
        }
    }
    
    func selectMainCategory(cat: MainCategoryModel) -> String? {
        for item in categories ?? [] {
            if item.id == cat.id {
                self.selectedMainCategory = cat
                self.selectedSubCategory = nil
                self.selectedPropertiesValues = nil
                return nil
            }
        }
        return "Not found item in category list"
    }
    
    func selectSubCategory(subCat: SubCategoryModel) -> String? {
        guard selectedMainCategory != nil else { return "select first main category" }
        for item in selectedMainCategory?.subcategories ?? [] {
            if item.id == subCat.id {
                self.selectedSubCategory = subCat
                self.selectedPropertiesValues = nil
                return nil
            }
        }
        return "Not found item in subcategory list in \(selectedMainCategory?.name ?? "")"
    }
    
    func selectPropertiesValues(propertyValue: PropertyValueModel) -> String? {
        guard selectedSubCategory != nil else { return "select first sub category" }
        if self.selectedPropertiesValues == nil {
            self.selectedPropertiesValues = []
        }
        self.selectedPropertiesValues?.removeAll(where: { pro in
            if pro.property?.id == propertyValue.property?.id {
                return true
            }
            return false
        })
        self.selectedPropertiesValues?.append(propertyValue)
        return "Not found item in list in property \(propertyValue.property?.name ?? "") in subcategory \(selectedSubCategory?.name ?? "")"
    }
    
    func valid() -> Bool {
        print("under development")
        return false
    }
    
    func display() {
        print("selected category: " ,selectedMainCategory?.id ?? 0 , " - ", selectedMainCategory?.name ?? "")
        print("selected subcategory: " ,selectedSubCategory?.id ?? 0 , " - ", selectedSubCategory?.name ?? "")
        print("properties of \(selectedSubCategory?.name ?? ""): ")
        print(" -- selected properties values -- : ")
        for item in selectedPropertiesValues ?? [] {
            print(item.property?.name ?? "", " - ", item.value ?? "")
        }
    }
    
    func getForm() -> String{
        var text = ""
        text = "selected category: " + (selectedMainCategory?.name ?? "No Selection") + "\n"
        text = text + "selected subcategory: " + (selectedSubCategory?.name ?? "No Selection") + "\n"
        text = text + "-- selected properties values --" + "\n"
        var propsValuesText = ""
        if (selectedPropertiesValues?.count ?? 0) > 0 {
            for item in selectedPropertiesValues ?? [] {
                propsValuesText = propsValuesText + ((item.property?.name ?? "")  + " - " + (item.value ?? "") ) + "\n"
            }
        }else {
            propsValuesText = "No Selection"
        }
        text = text + propsValuesText
        return text
    }
}
