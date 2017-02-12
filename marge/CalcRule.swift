//
//  CalcRule.swift
//  marge
//
//  Created by pwg on 2016/12/01.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import Foundation

import UIKit

class CalcRule: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CanelButton(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
