//
//  File.swift
//  sample1
//
//  Created by pwg on 2016/09/29.
//  Copyright © 2016年 pwg. All rights reserved.
//

import UIKit

class CalcResult: UIViewController {
    
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var TopScore: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
    let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
       
    /*正解数をresultに表示*/
    Result.text = appDelegate.CalcResult
    
        
    TopScore.text = String(AppSetting.Calc)
        
        if (AppSetting.Calc < Int(appDelegate.CalcResult!)!){
            AppSetting.Calc
                = Int(appDelegate.CalcResult!)!
        }

        
    }
    @IBAction func PushedButton1(_ sender: AnyObject) {
        
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func PushedButton2(_ sender: AnyObject) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
