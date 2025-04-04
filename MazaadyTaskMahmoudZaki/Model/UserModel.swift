//
//  UserModel.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 02/04/2025.
//

import Foundation

class UserModel {
    var id: Int = 0
    var name: String = ""
    var form: FormModel?
    
    func submitForm() -> Bool {
        return form?.valid() ?? false
    }
    
    func seeResult() -> FormModel? {
        form?.display()
        return form
    }
}

//Repo mock
//Repo API
