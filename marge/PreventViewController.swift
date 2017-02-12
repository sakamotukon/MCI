//
//  PreventViewController.swift
//  Home
//
//  Created by pwg on 2016/11/02.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
}


class PreventViewController: UIViewController {
    
    @IBOutlet weak var ChangeTra: UISegmentedControl!

    @IBOutlet var WalkMode: [UILabel]!
    
    @IBOutlet weak var green: UILabel!
    
    @IBOutlet weak var Stroop_Title: UILabel!
    @IBOutlet weak var Stroop_Button: UIButton!
    @IBOutlet weak var Calc_Title: UILabel!
    @IBOutlet weak var Calc_Button: UIButton!
    @IBOutlet weak var CountUp_Title: UILabel!
    @IBOutlet weak var CountUp_Button: UIButton!
    @IBOutlet weak var myStepDistanceMCI: UILabel!
    @IBOutlet weak var mySpeedMCI: UILabel!
    @IBOutlet weak var myStepDistance: UILabel!
    @IBOutlet weak var mySpeed: UILabel!
    @IBOutlet weak var myStep: UILabel!
    
    var myPedometer = CMPedometer() // ペドメーター(歩数計)を生成.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        BrainVisible()
        WalkInvisible()
        green.isHidden = false
        
        let backButtonItem = UIBarButtonItem(title: "前の画面に戻る", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    @IBAction func ChangeTraning(_ sender: AnyObject) {
        
        if(ChangeTra.selectedSegmentIndex == 0){
            //脳トレを表示して歩行矯正非表示
            BrainVisible()
            WalkInvisible()
        
        }else if(ChangeTra.selectedSegmentIndex == 1){
            //歩行矯正表示して脳トレ非表示
            BrainInvisible()
            WalkVisible()
            
            self.mySpeed.text = "75"
            self.myStep.text = "100"
            self.myStepDistance.text = "45"
                    

            self.myStepDistanceMCI.text = "もっと歩幅を広げよう"
            //self.myStepDistanceMCI.text = "このままの歩幅で歩こう"
                    
            self.mySpeedMCI.text = "もっと早く歩こう"
            //self.mySpeedMCI.text = "このままの速度で歩こう"
            /*
            // ペドメーター(歩数計)で計測開始.
            myPedometer.startUpdates(from: Date(), withHandler: {(pedometerData, error) in
                if let e = error {
                    print(e.localizedDescription)
                    return
                }
                
                guard let data = pedometerData else {
                    return
                }
                
                let myDistance = data.distance!.doubleValue
                let myTime: Double = data.endDate.timeIntervalSince(data.startDate)
                let mySpeed = myDistance / myTime
                let myStep = data.numberOfSteps
                let myStepDistance = myDistance / Double(myStep)
                
                self.mySpeed.text = "\(round(Double(mySpeed)))"
                self.myStep.text = "\(round(Double(myStep)))"
                self.myStepDistance.text = "\(round(Double(myStepDistance))*100))"
                
                if(((myStepDistance)*100) < 60){
                    self.myStepDistanceMCI.text = "もっと歩幅を広げよう"
                }else{
                    self.myStepDistanceMCI.text = "このままの歩幅で歩こう"
                }
                
                if(((Double(mySpeed))*100) < 80.0){
                    self.mySpeedMCI.text = "もっと早く歩こう"
                }else{
                    self.mySpeedMCI.text = "このままの速度で歩こう"
                }
                
            })
             */
        }
    }
    
    //歩行矯正表示
    func WalkVisible(){
        for testLabel in WalkMode{
            testLabel.isHidden  = false
        }
        mySpeedMCI.isHidden = false
        myStepDistanceMCI.isHidden = false
        myStepDistance.isHidden = false
        myStep.isHidden = false
        mySpeed.isHidden = false
        green.isHidden = false
    
    }
    //歩行矯正非表示
    func WalkInvisible(){
        for testLabel in WalkMode{
            testLabel.isHidden  = true
        }
        mySpeedMCI.isHidden = true
        myStepDistanceMCI.isHidden = true
        myStepDistance.isHidden = true
        myStep.isHidden = true
        mySpeed.isHidden = true
        green.isHidden = false
    }
    
    //脳トレ表示
    func BrainVisible(){
        Stroop_Title.isHidden = false
        Stroop_Button.isHidden = false
        Calc_Title.isHidden = false
        Calc_Button.isHidden = false
        CountUp_Title.isHidden = false
        CountUp_Button.isHidden = false
        green.isHidden = false
    }
    //脳トレ非表示
    func BrainInvisible(){
        Stroop_Title.isHidden = true
        Stroop_Button.isHidden = true
        Calc_Title.isHidden = true
        Calc_Button.isHidden = true
        CountUp_Title.isHidden = true
        CountUp_Button.isHidden = true
        green.isHidden = false
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
