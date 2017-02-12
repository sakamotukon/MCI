//
//  ChooseTraController.swift
//  
//
//  Created by pwg on 2016/11/11.
//
//

import Foundation
import UIKit

class ChooseTraController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let nv = navigationController {
            _ = !nv.isNavigationBarHidden
            nv.setNavigationBarHidden(false, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
