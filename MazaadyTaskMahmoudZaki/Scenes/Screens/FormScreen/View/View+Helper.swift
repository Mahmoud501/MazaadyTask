//
//  View+Helper.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 05/04/2025.
//

import Foundation
import UIKit

extension ViewController {
    
    
    //setups
    
    func setupDropDowns() {
        setupMainCategory()
        setupSubCategory()
    }
    
    func setupProperties() {
        if (controller.selectedSubCategory?.properties?.count ?? 0) > 0 {
            vuStackProperties.isHidden = false
            for item in controller.selectedSubCategory?.properties ?? [] {
                let vuDropDown = DropDownView.init(frame: .zero)
                vuDropDown.placeHolder = item.name
                vuDropDown.tag = item.id
                vuDropDown.didClicked = { [weak self] in
                    guard let self = self else { return }
                    if (item.values?.count ?? 0) > 0 {
                        self.showPopupProperty(item: item, vuDropDown: vuDropDown)
                    }else {
                        Task {[weak self] in
                            guard let self = self else {return}
                            vuDropDown.isLoading = true
                            let parentValue = controller.selectedPropertiesValues?.first(where: {$0.property?.id == item.parent?.id})
                            if let result = await item.getPropertyValues(parentValueId: parentValue?.id) {
                                vuDropDown.errorText = result
                            }else {
                                self.showPopupProperty(item: item, vuDropDown: vuDropDown)
                            }
                            vuDropDown.isLoading = false
                        }
                    }
                }
                vuStackProperties.addArrangedSubview(vuDropDown)
            }
        }else {
            vuStackProperties.isHidden = true
        }
    }
    
    func showPopupProperty(item: PropertyModel, vuDropDown: DropDownView) {
        vuDropDown.errorText = nil
        let data = item.values?.map({ item in
            return DropDownDataSource(id: item.id, name: item.id == 0 ? "Other" : item.value)
        })
        self.showPopupWith(data: data ?? [], title: vuDropDown.placeHolder) { [weak self] id in
            guard let self  = self else { return }
            if let propertyValue = item.values?.first(where: {$0.id == id}) {
                //select property
                _ = controller.selectPropertiesValues(propertyValue: propertyValue)
                vuDropDown.value = propertyValue.id == 0 ? "Other" : propertyValue.value ?? ""
                
                //clear children values
                for pro in controller.selectedSubCategory?.properties ?? [] {
                    if pro.parent?.id == item.id {
                        vuStackProperties.arrangedSubviews.forEach { view in
                            if view.tag == pro.id {
                                pro.values = nil
                                let dropDown = view as? DropDownView
                                dropDown?.value = dropDown?.placeHolder ?? ""
                                dropDown?.txtCustomValue.text = ""
                                dropDown?.txtCustomValue.isHidden = true
                            }
                        }
                    }
                }
                
                //handler other select
                if propertyValue.id == 0 {
                    propertyValue.value = ""
                    vuDropDown.txtCustomValue.isHidden = false
                    vuDropDown.didChangeCustomValue = { [weak self] value in
                        guard let self = self else { return }
                        propertyValue.value = value
                    }
                }else {
                    vuDropDown.didChangeCustomValue = nil
                    vuDropDown.txtCustomValue.isHidden = true
                }
            }
        }
    }
    
    func setupSubCategory() {
        ddSubCategory.placeHolder = "Sub Category"
        ddSubCategory.didClicked = { [weak self] in
            guard let self = self else { return }
            if (controller.selectedMainCategory?.subcategories?.count ?? 0) == 0 {
                self.getSubCategories()
            }else {
                let data = controller.selectedMainCategory?.subcategories?.map({ item in
                    return DropDownDataSource(id: item.id, name: item.name)
                })
                self.showPopupWith(data: data ?? [], title: ddSubCategory.placeHolder) { [weak self] id in
                    guard let self  = self else { return }
                    if let subcat = controller.selectedMainCategory?.subcategories?.first(where: {$0.id == id}) {
                        _ = controller.selectSubCategory(subCat: subcat)
                        ddSubCategory.value = controller.selectedSubCategory?.name ?? ""
                        self.clearForSubCategory()
                        self.getProperites()
                        
                    }
                }
            }
        }
    }
        
    func setupMainCategory() {
        ddMainCategory.placeHolder = "Main Category"
        ddMainCategory.didClicked = { [weak self] in
            guard let self = self else { return }
            let data = controller.categories?.map({ item in
                return DropDownDataSource(id: item.id, name: item.name)
            })
            self.showPopupWith(data: data ?? [], title: ddMainCategory.placeHolder) { [weak self] id in
                guard let self  = self else { return }
                if let cat = controller.categories?.first(where: {$0.id == id}) {
                    _ = controller.selectMainCategory(cat: cat)
                    ddMainCategory.value = controller.selectedMainCategory?.name ?? ""
                    self.clearForMainCategory()
                    self.getSubCategories()
                }
            }
        }
    }
    
    func showPopupWith(data: [DropDownDataSource], title: String, didSelect: ((Int)->())?) {
        self.showOpactityView(show: false)
        let vc = DropDownPopup.init(nibName: "DropDownPopup", bundle: nil)
        vc.popupTitle = title
        vc.data = data
        vc.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        vc.modalPresentationStyle = .overFullScreen
        vc.didClosed = { [weak self] in
            guard let self = self else { return }
            self.showOpactityView(show: true)
        }
        vc.didSelect = { [weak self] id in
            guard let _ = self else { return }
            didSelect?(id)
        }
        self.present(vc, animated: true)

    }
    
    func showOpactityView(show: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = show ? 1 : 0.4
        }
    }
    
}
