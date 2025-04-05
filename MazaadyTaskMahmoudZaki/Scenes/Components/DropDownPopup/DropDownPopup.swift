//
//  DropDownPopup.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 04/04/2025.
//

import UIKit


struct DropDownDataSource {
    var id: Int?
    var name: String?
}

class DropDownPopup: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    var data: [DropDownDataSource] = [] {
        didSet {
            filteredData = data
        }
    }
    var filteredData: [DropDownDataSource] = []
    var popupTitle: String = ""
    var initialTouchPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    var didClosed: (()->())?
    var didSelect: ((Int)->())?

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var vuDrag: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vuDrag.layer.cornerRadius = 10
        vuDrag.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        vuDrag.layer.masksToBounds = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.lblTitle.text = self.popupTitle
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func dragView(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0{
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > self.vuContain.frame.height * 0.25 {
                self.didClosed?()
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         if scroll == 0{
             return true
         }
         return false
     }
    
     var scroll : CGFloat = 0.0
     
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
         scroll = scrollView.contentOffset.y
     }
    
    
    @IBAction func closeClicked(_ sender: Any) {
        close()
    }
    
    
    func close(compeletion: (()->())? = nil) {
        self.didClosed?()
        UIView.animate(withDuration: 0.25, animations: {
            var frm = self.vuContain.frame
            frm.origin.y = UIScreen.main.bounds.size.height
            self.vuContain.frame = frm
        }) { (com) in
            self.dismiss(animated: false, completion: nil)
            compeletion?()
        }

    }



}
