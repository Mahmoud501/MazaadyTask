//
//  ViewController.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 02/04/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ddMainCategory: DropDownView!
    
    var selectedValue: String? {
        didSet {
            ddMainCategory.value = selectedValue ?? "Main Category"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ddMainCategory.value = "Main Category"
        ddMainCategory.didClicked = { [weak self] in
            guard let self = self else { return }
            self.showOpactityView(show: false)
            let vc = DropDownPopup.init(nibName: "DropDownPopup", bundle: nil)
            vc.popupTitle = ddMainCategory.value
            vc.data = [DropDownDataSource.init(id: 1, name: "item1"), DropDownDataSource.init(id: 2, name: "item2"),
                       DropDownDataSource.init(id: 3, name: "item3"), DropDownDataSource.init(id: 4, name: "item4"),
                       DropDownDataSource.init(id: 5, name: "item5"), DropDownDataSource.init(id: 6, name: "item6"),
                       DropDownDataSource.init(id: 7, name: "item7"), DropDownDataSource.init(id: 8, name: "item8")]
            vc.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            vc.modalPresentationStyle = .overFullScreen
            vc.didClosed = { [weak self] in
                guard let self = self else { return }
                self.showOpactityView(show: true)
            }
            vc.didSelect = { [weak self] index in
                guard let self = self else { return }
                print(index)
                self.selectedValue = vc.data[index].name
            }
            self.present(vc, animated: true)
        }
    }
    
    func showOpactityView(show: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = show ? 1 : 0.4
        }
    }


}

