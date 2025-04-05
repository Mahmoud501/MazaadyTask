//
//  DropDownView.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 04/04/2025.
//

import Foundation
import UIKit

class DropDownView: UIView {
        
    var didClicked: (()->())?
    var didChangeCustomValue: ((String)->())?
    
    var placeHolder: String = "" {
        didSet {
            lblValue.text = placeHolder
        }
    }
    
    var value: String = "" {
        didSet {
            lblValue.text = value
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            isLoading == true ? activity.startAnimating() : activity.stopAnimating()
        }
    }
    
    var errorText: String? {
        didSet {
            if (errorText ?? "") == "" {
                lblError.text = ""
                lblError.isHidden = true
            }else {
                lblError.text = errorText
                lblError.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var txtCustomValue: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBAction func valueDidChange(_ sender: Any) {
        didChangeCustomValue?(txtCustomValue.text ?? "")
    }
    
    
    @IBAction func clicked(_ sender: Any) {
        if isLoading == false {
            didClicked?()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commit()
        
    }
    func commit(){
        Bundle.main.loadNibNamed("DropDownView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
        lblError.text = ""
        lblError.isHidden = true
        txtCustomValue.isHidden = true
    }

}
