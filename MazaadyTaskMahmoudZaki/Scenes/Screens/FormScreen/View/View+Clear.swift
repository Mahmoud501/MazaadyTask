//
//  View+Clear.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 05/04/2025.
//

import Foundation
import UIKit

extension ViewController {
    
    func clearAll() {
        ddMainCategory.value = ddMainCategory.placeHolder
        clearForMainCategory()
    }
    
    func clearForMainCategory() {
        ddSubCategory.value = ddSubCategory.placeHolder
        clearForSubCategory()
    }
    
    func clearForSubCategory() {
        _ = vuStackProperties.arrangedSubviews.map { view in
            view.removeFromSuperview()
        }
    }
    
    
    
    
        
    
}
