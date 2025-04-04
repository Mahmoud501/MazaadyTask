//
//  AppDelegate.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 02/04/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let form = FormModel()
        Task {
            /////////////////////////////////////                           user get categories
            if let result = await form.getCategories() {
                print("error: ", result)
            }else {
                if let cat = form.categories?.last {
                    /////////////////////////////////////                           select main category
                    if let result = form.selectMainCategory(cat: cat) {
                        print("error: ", result)
                    }else {
                        /////////////////////////////////////                           get sub categories of main-cat
                        await form.selectedMainCategory?.getSubCategories()
                        if let subcat = form.selectedMainCategory?.subcategories?.first {
                            /////////////////////////////////////                           select subCategory
                            if let result = form.selectSubCategory(subCat: subcat) {
                                print("error: ", result)
                            }else {
                                /////////////////////////////////////                           get properties of selected sub-cat
                                await form.selectedSubCategory?.getProperties()
                                //set parent id always be second one is parent of first (for testing)
                                if (form.selectedSubCategory?.properties?.count ?? 0) > 1 {
                                    form.selectedSubCategory?.properties?[1].parent = form.selectedSubCategory?.properties?.first
                                }
                                if (form.selectedSubCategory?.properties?.count ?? 0)  > 0 {
                                    /////////////////////////////////////                           get properties values of property
                                    if let property = form.selectedSubCategory?.properties?.first {
                                        await property.getPropertyValues(parentValueId: property.parent?.id)
                                    }
                                    
                                    if let value = form.selectedSubCategory?.properties?.first?.values?.first {
                                        _ = form.selectPropertiesValues(propertyValue: value)
                                    }
                                    if let value = form.selectedSubCategory?.properties?.first?.values?.last {
                                        _ = form.selectPropertiesValues(propertyValue: value)
                                    }
                                    if let value = form.selectedSubCategory?.properties?.first?.values?.first {
                                        _ = form.selectPropertiesValues(propertyValue: value)
                                    }
                                    
                                    if let property = form.selectedSubCategory?.properties?.last {
                                        await form.selectedSubCategory?.properties?.last?.getPropertyValues(parentValueId: property.parent?.id)
                                        if let value = form.selectedSubCategory?.properties?.last?.values?[1] {
                                            _ = form.selectPropertiesValues(propertyValue: value)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            form.display()
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

