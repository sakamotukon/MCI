//
//  StroopResult.swift
//  marge
//
//  Created by pwg on 2016/11/24.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import Foundation
import UIKit

class StroopResult: UIViewController {
    
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var TopScore: UILabel!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        /*正解数をresultに表示*/
        Result.text = appDelegate.StroopResult
        TopScore.text = String(AppSetting.Stroop)
        
        if (AppSetting.Stroop < Int(appDelegate.StroopResult!)!){
            AppSetting.Stroop = Int(appDelegate.StroopResult!)!
        }
        
    }
    
    @IBAction func PushedButton1(_ sender: AnyObject) {
        
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func PushedButton2(_ sender: AnyObject) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
