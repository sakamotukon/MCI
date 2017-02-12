//
//  ResultViewController.swift
//  CountUp
//
//  Created by pwg on 2016/09/30.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController
{
    @IBOutlet weak var Result: UILabel!
    
    //正解数
    @IBOutlet weak var Result2: UILabel!
    @IBOutlet weak var TopScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            Result2.text = appDelegate.message
        
        TopScore.text = String(AppSetting.CountUp)
        
        if (AppSetting.CountUp < Int(appDelegate.message!)!){
            AppSetting.CountUp
                = Int(appDelegate.message!)!
        }
    }
    @IBAction func PushedButton(_ sender: AnyObject) {
        
      self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        //self.dismiss(animated: true, completion: nil)
        
    }
   
    @IBAction func PushedButton2(_ sender: AnyObject) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
