//
//  Walk_training.swift
//  marge
//
//  Created by 坂本あや on 2016/11/25.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import UIKit
import CoreMotion

class Walk_training: UIViewController {
    
    var myPedometer = CMPedometer() // ペドメーター(歩数計)を生成.
    
    @IBOutlet weak var myStepDistance: UILabel!
    @IBOutlet weak var mySpeed: UILabel!
    @IBOutlet weak var myStep: UILabel!
    
    @IBOutlet weak var myMCIStepDistance: UILabel!
    @IBOutlet weak var myMCISpeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                self.myMCIStepDistance.text = "もっと歩幅を広げよう"
            }else{
                self.myMCIStepDistance.text = "このままの歩幅で歩こう"
            }
            
            if(((Double(mySpeed))*100) < 80.0){
                self.myMCISpeed.text = "もっと早く歩こう"
            }else{
                self.myMCISpeed.text = "このままの速度で歩こう"
            }
            
        })
    }
}


