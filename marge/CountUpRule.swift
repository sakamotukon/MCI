//
//  CountUpRule.swift
//  marge
//
//  Created by pwg on 2016/12/01.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import Foundation

import UIKit

class CountURule: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CancelButton(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
