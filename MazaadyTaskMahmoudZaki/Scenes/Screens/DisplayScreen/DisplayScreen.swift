//
//  DisplayScreen.swift
//  MazaadyTaskMahmoudZaki
//
//  Created by Mahmoud Zaki on 05/04/2025.
//

import UIKit

class DisplayScreen: UIViewController {

    var text: String?
    
    @IBOutlet weak var lblDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblDesc.text = text
    }

}
