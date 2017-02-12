//
//  ConfigViewController.swift
//  Home
//
//  Created by pwg on 2016/11/02.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import Foundation
import UIKit

class ConfigViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 37/255, green: 115/255, blue: 16/255, alpha: 1)
        
        
        //37,115,16
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
