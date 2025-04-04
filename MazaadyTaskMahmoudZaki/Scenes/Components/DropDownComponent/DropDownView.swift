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
    
    var value: String = "" {
        didSet {
            lblValue.text = value
        }
    }
    
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet var contentView: UIView!
        
    @IBAction func clicked(_ sender: Any) {
        didClicked?()
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
    }

}
