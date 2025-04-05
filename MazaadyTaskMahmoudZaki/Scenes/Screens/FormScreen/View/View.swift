//
//  ViewController.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 02/04/2025.
//

import UIKit

class ViewController: UIViewController {

    //outlets
    @IBOutlet weak var ddMainCategory: DropDownView!
    @IBOutlet weak var ddSubCategory: DropDownView!
    @IBOutlet weak var vuStackProperties: UIStackView!
    
    //actions
    @IBAction func submitClikced(_ sender: Any) {
        controller.display()
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayScreen") as? DisplayScreen {
            vc.text = controller.getForm()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
    var controller = FormController()
    
    //lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupDropDowns()
        getCategories()
     
    }
    
    func getCategories() {        
        Task { [weak self] in
            guard let self = self else { return }
            ddMainCategory.isLoading = true
            if let result = await controller.getCategories() {
                ddMainCategory.errorText = result
            }            
            ddMainCategory.isLoading = false
        }
    }
    
    func getSubCategories() {
        if controller.selectedMainCategory == nil {
            ddSubCategory.errorText = "please select first main category"
        }else {
            ddSubCategory.errorText = nil
            Task { [weak self] in
                guard let self = self else { return }
                ddSubCategory.isLoading = true
                if let result = await controller.selectedMainCategory?.getSubCategories() {
                    ddSubCategory.errorText = result
                }
                ddSubCategory.isLoading = false
            }
        }
    }
    
    func getProperites() {
        if controller.selectedSubCategory == nil {
            ddSubCategory.errorText = "please select first sub category"
        }else {
            ddSubCategory.errorText = nil
            Task { [weak self] in
                guard let self = self else { return }
                ddSubCategory.isLoading = true
                if let result = await controller.selectedSubCategory?.getProperties() {
                    ddSubCategory.errorText = result
                }else {
                    self.setupProperties()
                }
                ddSubCategory.isLoading = false
                //set parent id always be second one is parent of first (for testing)
                if (controller.selectedSubCategory?.properties?.count ?? 0) > 1 {
                    controller.selectedSubCategory?.properties?[1].parent = controller.selectedSubCategory?.properties?.first
                }
            }
        }
    }


}

