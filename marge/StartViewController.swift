//
//  StateViewController.swift
//  Home
//
//  Created by pwg on 2016/11/02.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import UIKit
import CoreMotion
import HealthKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var myStepDistanceLabel: UILabel!
    @IBOutlet weak var mySpeedLabel: UILabel!
    @IBOutlet weak var myStepLabel: UILabel!
    @IBOutlet weak var myWeekMCI: UILabel!
    
    @IBOutlet weak var weekLabel: UILabel!
    
    var myHealthStore = HKHealthStore()

    //Healthデータへのアクセスを申請.
    
    private func requestAuthorization(){
        // 読み込みを許可する型.
        let types = Set(arrayLiteral:
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceSwimming)!,
                        HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWheelchair)!
        )
        
        // HealthStoreへのアクセス承認をおこなう.
        myHealthStore.requestAuthorization(toShare: types, read: types, completion: { (success, error) in
            if let e = error {
                print("Error: \(e.localizedDescription)")
            }
            print(success ? "Success" : "Failure")
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // HealthStoreへの許可を申請.
        requestAuthorization()
    }
    
    var myPedometer = CMPedometer() // ペドメーター(歩数計)を生成.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = Calendar.init(identifier: Calendar.Identifier.japanese)
        let now = Date()
        
        // 今日の日付
        let StartWeekDate = calendar.startOfDay(for: now)
        // 今日から~~
        let LastWeekDate = calendar.date(byAdding: Calendar.Component.day, value: -7, to: StartWeekDate)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy日MM月dd日"
        
        let formattedStartWeekDate = formatter.string(from: StartWeekDate)
        let formattedLastWeekDate = formatter.string(from: LastWeekDate)
        
        weekLabel.text = "\(String(describing: formattedLastWeekDate)) ~ \(String(describing: formattedStartWeekDate))"
        
        var cnt = 0
        
        //　日毎用歩幅
        var myStepDistanceCen = 0.0
        var myStepDistance40min = 0
        var myStepDistance50min = 0
        var myStepDistance60min = 0
        var myStepDistance70min = 0
        var myStepDistance80min = 0
        var myStepDistance90min = 0
        
        //　日毎用歩行速度
        var mySpeedCen = 0.0
        var mySpeed48min = 0
        var mySpeed54min = 0
        var mySpeed60min = 0
        var mySpeed66min = 0
        var mySpeed72min = 0
        var mySpeed78min = 0
        var mySpeed84min = 0
        
        //　週毎用歩幅
        var myWeekStepDistanceCen = 0.0
        var myWeekStepDistance40min = 0
        var myWeekStepDistance50min = 0
        var myWeekStepDistance60min = 0
        var myWeekStepDistance70min = 0
        var myWeekStepDistance80min = 0
        var myWeekStepDistance90min = 0
        
        //　週毎用歩行速度
        
        var myWeekSpeedCen = 0.0
        var myWeekSpeed48min = 0
        var myWeekSpeed54min = 0
        var myWeekSpeed60min = 0
        var myWeekSpeed66min = 0
        var myWeekSpeed72min = 0
        var myWeekSpeed78min = 0
        var myWeekSpeed84min = 0
        
        print("初期画面")
        
        for j in -1..<7 {
            for i in 1..<720 {
                
                if(i == 0){
                    
                    //　初期
                    
                    //　日毎用歩幅
                    myStepDistanceCen = 0.0
                    myStepDistance40min = 0
                    myStepDistance50min = 0
                    myStepDistance60min = 0
                    myStepDistance70min = 0
                    myStepDistance80min = 0
                    myStepDistance90min = 0
                    
                    //　日毎用歩行速度
                    mySpeedCen = 0.0
                    mySpeed48min = 0
                    mySpeed54min = 0
                    mySpeed60min = 0
                    mySpeed66min = 0
                    mySpeed72min = 0
                    mySpeed78min = 0
                    mySpeed84min = 0
                }
                
                // 今日の日付
                var startDate = calendar.startOfDay(for: now)
                startDate = calendar.date(byAdding: Calendar.Component.day, value: -j, to: startDate)!
                // 今日から~~
                let endDate = calendar.date(byAdding: Calendar.Component.minute, value: -i, to: startDate)!
                let start_endDate = calendar.date(byAdding: Calendar.Component.minute, value: 1, to: endDate)!
                myPedometer.queryPedometerData(from: endDate, to: start_endDate, withHandler: {(pedmeterData, error) in
                    if let e = error {
                        print(e.localizedDescription)
                        return
                    }
                    guard let data = pedmeterData else {
                        return
                    }
                    
                    let myDistance = data.distance!.doubleValue
                    let myTime: Double = data.endDate.timeIntervalSince(data.startDate)
                    let mySpeed: Double = (Double(myDistance))
                    let myStep = data.numberOfSteps
                    let myStepDistance: Double = (myDistance / Double(myStep))*100
                    
                    if (Int(myStep) > 70 && myStepDistance > 40 && myStepDistance < 100 && mySpeed > 42 && mySpeed < 90){
                        
                        cnt = cnt + 1
                        
                        //　歩行速度代入
                        if(mySpeed <= 54 && mySpeed >= 48){
                            mySpeed48min = mySpeed48min + 1
                            myWeekSpeed48min = myWeekSpeed48min + 1
                        }
                        else if(mySpeed <= 54 && mySpeed > 48){
                            mySpeed54min = mySpeed54min + 1
                            myWeekSpeed54min = myWeekSpeed54min + 1
                        }
                        else if(mySpeed <= 60 && mySpeed > 54){
                            mySpeed60min = mySpeed60min + 1
                            myWeekSpeed60min = myWeekSpeed60min + 1
                        }
                        else if(mySpeed <= 66 && mySpeed > 60){
                            mySpeed66min = mySpeed66min + 1
                            myWeekSpeed66min = myWeekSpeed66min + 1
                        }
                        else if(mySpeed <= 72 && mySpeed > 66){
                            mySpeed72min = mySpeed72min + 1
                            myWeekSpeed72min = myWeekSpeed72min + 1
                        }
                        else if(mySpeed <= 78 && mySpeed > 72){
                            mySpeed78min = mySpeed78min + 1
                            myWeekSpeed78min = myWeekSpeed78min + 1
                        }
                        else if(mySpeed <= 84 && mySpeed > 78){
                            mySpeed84min = mySpeed84min + 1
                            myWeekSpeed84min = myWeekSpeed84min + 1
                        }
                        
                        // 歩幅代入
                        if(myStepDistance < 40){
                            myStepDistance40min = myStepDistance40min + 1
                            myWeekStepDistance40min = myWeekStepDistance40min + 1
                        }
                        else if(myStepDistance < 50 && myStepDistance > 40){
                            myStepDistance50min = myStepDistance50min + 1
                            myWeekStepDistance50min = myWeekStepDistance50min + 1
                        }
                        else if(myStepDistance < 60 && myStepDistance > 50){
                            myStepDistance60min = myStepDistance60min + 1
                            myWeekStepDistance60min = myWeekStepDistance60min + 1
                        }
                        else if(myStepDistance < 70 && myStepDistance > 60){
                            myStepDistance70min = myStepDistance70min + 1
                            myWeekStepDistance70min = myWeekStepDistance70min + 1
                        }
                        else if(myStepDistance < 80 && myStepDistance > 70){
                            myStepDistance80min = myStepDistance80min + 1
                            myWeekStepDistance80min = myWeekStepDistance80min + 1
                        }else{
                            myStepDistance90min = myStepDistance90min + 1
                            myWeekStepDistance90min = myWeekStepDistance90min + 1
                        }
                    }
                    
                    if(i == 719){
                        
                        //　歩幅中央値
                        if(myStepDistance80min >= myStepDistance70min && myStepDistance80min >= myStepDistance60min
                            && myStepDistance80min >= myStepDistance50min && myStepDistance80min >= myStepDistance40min){
                            if(myStepDistance80min > 0){
                                myStepDistanceCen = 75
                            }
                        }else if(myStepDistance70min >= myStepDistance60min && myStepDistance70min >= myStepDistance50min
                            && myStepDistance70min >= myStepDistance40min){
                            myStepDistanceCen = 65
                        }else if(myStepDistance60min >= myStepDistance50min && myStepDistance60min >= myStepDistance40min){
                            myStepDistanceCen = 55
                        }else if(myStepDistance50min >= myStepDistance40min){
                            myStepDistanceCen = 45
                        }else{
                            myStepDistanceCen = 35
                        }
                        
                        //歩行速度中央値
                        if(mySpeed84min >= mySpeed78min && mySpeed84min >= mySpeed72min
                            && mySpeed84min >= mySpeed66min && mySpeed84min >= mySpeed60min
                            && mySpeed84min >= mySpeed54min && mySpeed84min >= mySpeed48min){
                            if(mySpeed84min > 0){
                                mySpeedCen = 84
                            }
                        }else if(mySpeed78min >= mySpeed72min && mySpeed78min >= mySpeed66min
                            && mySpeed78min >= mySpeed60min && mySpeed78min >= mySpeed54min
                            && mySpeed78min >= mySpeed48min){
                            mySpeedCen = 78
                        }else if(mySpeed72min >= mySpeed66min && mySpeed72min >= mySpeed60min
                            && mySpeed72min >= mySpeed54min && mySpeed72min >= mySpeed48min){
                            mySpeedCen = 72
                        }else if(mySpeed66min >= mySpeed60min && mySpeed66min >= mySpeed54min
                            && mySpeed66min >= mySpeed48min){
                            mySpeedCen = 66
                        }else if(mySpeed60min >= mySpeed54min && mySpeed60min >= mySpeed48min){
                            mySpeedCen = 60
                        }else if(mySpeed54min >= mySpeed48min){
                            mySpeedCen = 54
                        }else{
                            mySpeedCen = 48
                        }
                        
                        // 今日の日付
                        let start_Date = calendar.date(byAdding: Calendar.Component.day, value: -j, to: startDate)!
                        //　1日の値代入
                        if(mySpeedCen != 0.0 && myStepDistanceCen != 0.0){
                            print(mySpeedCen, myStepDistanceCen)
                            self.writeData(distanceSwimming: mySpeedCen, distanceWheelchair: myStepDistanceCen, startDate: start_Date, endDate: start_Date)
                        }
                    }
                })
            }
        }
        
        //歩数表示
        // 今日の日付
        var startDate = calendar.startOfDay(for: now)
        startDate = calendar.date(byAdding: Calendar.Component.day, value: 1, to: startDate)!
        // 今日から~~
        let endDate = calendar.date(byAdding: Calendar.Component.day, value: -8, to: startDate)!
        //let predicate = HKQuery.predicateForSamples(withStart: endDate, end: startDate, options: [])
        
        myPedometer.queryPedometerData(from: endDate, to: startDate, withHandler: {(pedmeterData, error) in
            if let e = error {
                print(e.localizedDescription)
                return
            }
            guard let data = pedmeterData else {
                return
            }
            
            let myStep = data.numberOfSteps
            self.myStepLabel.text = "\(String(describing: myStep))"
            
            //　週間
            
            //　歩幅中央値
            if(myWeekStepDistance80min >= myWeekStepDistance70min && myWeekStepDistance80min >= myWeekStepDistance60min
                && myWeekStepDistance80min >= myWeekStepDistance50min && myWeekStepDistance80min >= myWeekStepDistance40min){
                myWeekStepDistanceCen = 75
            }else if(myWeekStepDistance70min >= myWeekStepDistance60min && myWeekStepDistance70min >= myWeekStepDistance50min
                && myWeekStepDistance70min >= myWeekStepDistance40min){
                myWeekStepDistanceCen = 65
            }else if(myWeekStepDistance60min >= myWeekStepDistance50min && myWeekStepDistance60min >= myWeekStepDistance40min){
                myWeekStepDistanceCen = 55
            }else if(myWeekStepDistance50min >= myWeekStepDistance40min){
                myStepDistanceCen = 45
            }else{
                myWeekStepDistanceCen = 35
            }
            
            //歩行速度中央値
            
            //歩行速度中央値
            if(myWeekSpeed84min >= myWeekSpeed78min && myWeekSpeed84min >= myWeekSpeed72min
                && myWeekSpeed84min >= myWeekSpeed66min && myWeekSpeed84min >= myWeekSpeed60min
                && myWeekSpeed84min >= myWeekSpeed54min && myWeekSpeed84min >= myWeekSpeed48min){
                if(myWeekSpeed84min > 0){
                    myWeekSpeedCen = 84
                }
            }else if(myWeekSpeed78min >= myWeekSpeed72min && myWeekSpeed78min >= myWeekSpeed66min
                && myWeekSpeed78min >= myWeekSpeed60min && myWeekSpeed78min >= myWeekSpeed54min
                && myWeekSpeed78min >= myWeekSpeed48min){
                myWeekSpeedCen = 78
            }else if(myWeekSpeed72min >= myWeekSpeed66min && myWeekSpeed72min >= myWeekSpeed60min
                && myWeekSpeed72min >= myWeekSpeed54min && myWeekSpeed72min >= myWeekSpeed48min){
                myWeekSpeedCen = 72
            }else if(myWeekSpeed66min >= myWeekSpeed60min && myWeekSpeed66min >= myWeekSpeed54min
                && myWeekSpeed66min >= myWeekSpeed48min){
                myWeekSpeedCen = 66
            }else if(myWeekSpeed60min >= myWeekSpeed54min && myWeekSpeed60min >= myWeekSpeed48min){
                myWeekSpeedCen = 60
            }else if(myWeekSpeed54min >= myWeekSpeed48min){
                myWeekSpeedCen = 54
            }else{
                myWeekSpeedCen = 48
            }
            
            print(myWeekSpeedCen, myWeekStepDistanceCen)
            self.myStepDistanceLabel.text = " \(Int(myWeekStepDistanceCen))"
            self.mySpeedLabel.text = "\(Int(myWeekSpeedCen))"
            
            if(myWeekStepDistanceCen < 50 || myWeekSpeedCen < 48){
                self.myWeekMCI.text = "MCIの兆候あり"
            }else{
                self.myWeekMCI.text = "MCIの兆候なし"
            }
        })
    }

    /*
     データの書き込み.
     */
    private func writeData(distanceSwimming: Double, distanceWheelchair: Double, startDate: Date, endDate: Date){
        
        // BodyMassの登録用データタイプ.
        let typeOfdistanceSwimming = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceSwimming)
        let typeOfdistanceWheelchair = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWheelchair)
        
        // 単位とセットのデータを生成.
        let centimeter = HKUnit(from: LengthFormatter.Unit.centimeter)
        let mydistanceSwimming = HKQuantity(unit:centimeter, doubleValue: distanceSwimming)
        let mydistanceWheelchair = HKQuantity(unit:centimeter, doubleValue: distanceWheelchair)
        
        // StoreKit保存用データを作成.
        let mydistanceSwimmingData = HKQuantitySample(type: typeOfdistanceSwimming!, quantity: mydistanceSwimming, start: startDate, end: endDate)
        let mydistanceWheelchairData = HKQuantitySample(type: typeOfdistanceWheelchair!, quantity: mydistanceWheelchair, start: startDate, end: endDate)
        
        // 保存データを一つの配列にまとめる.
        //let mySaveObjects = NSArray(array: [myBPSystolicData,myBPDiastolicData])
        
        // HealthStoreに登録.
        myHealthStore.save([mydistanceSwimmingData, mydistanceWheelchairData], withCompletion: { success, error in
            print(success ? "Success" : "Failure")
            
        })
    }
 
}
