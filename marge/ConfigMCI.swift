//
//  ConfigMCI.swift
//  
//
//  Created by pwg on 2016/12/01.
//
//

import Foundation

import UIKit

class ConfigMCI: UIViewController {
    
    @IBOutlet weak var aaa: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 37/255, green: 115/255, blue: 16/255, alpha: 1)
         self.navigationController?.setNavigationBarHidden(false, animated: true)
        //37,115,16
    }
    @IBAction func BackButton(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
