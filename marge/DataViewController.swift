//
//  DataViewController.swift
//  Home
//
//  Created by pwg on 2016/11/02.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import Foundation
import UIKit
import Charts
import HealthKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var Graph: LineChartView!
    @IBOutlet weak var DataSelect: UISegmentedControl!
    @IBOutlet weak var Select_s_m: UISegmentedControl!
    var Flag:Int = Int(TID_NULL)
  
    @IBOutlet weak var Xlabel: UILabel!
    @IBOutlet weak var Ylabel: UILabel!
    
    var myHealthStore = HKHealthStore()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // HealthStoreへの許可を申請.
        requestAuthorization()
    }
    
    //Healthデータへのアクセスを申請
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        //setChart(values: unitsSold,Data:week)
        Flag=0
        readDataDW(x: 0)
        Xlabel.text="(日)"
        Ylabel.text="(cm)"
       
    }
    @IBAction func DataChanged_s_m(_ sender: AnyObject) {
        if (Select_s_m.selectedSegmentIndex == 0) {
            //最初のセグメントが0。セグメント数に合わせて条件分岐を
            Flag=0
            
             if (DataSelect.selectedSegmentIndex == 0) {
                //最初のセグメントが0。セグメント数に合わせて条件分岐を
                readDataDW(x: 0)
                Xlabel.text="(日)"
                Ylabel.text="(cm)"
            } else if (DataSelect.selectedSegmentIndex == 1) {
                readDataDW(x: 1)
                Xlabel.text="(週)"
                Ylabel.text="(cm)"
            } else if (DataSelect.selectedSegmentIndex == 2){
                readDataDW(x: 2)
                Xlabel.text="(月)"
                Ylabel.text="(cm)"
            }

            
        } else if (Select_s_m.selectedSegmentIndex == 1) {
            Flag=1
            
            if (DataSelect.selectedSegmentIndex == 0) {
                //最初のセグメントが0。セグメント数に合わせて条件分岐を
                readDataDS(y: 0)
                Xlabel.text="(日)"
                Ylabel.text="(m/m)"
            } else if (DataSelect.selectedSegmentIndex == 1) {
                readDataDS(y: 1)
                Xlabel.text="(週)"
                Ylabel.text="(m/m)"
            } else if (DataSelect.selectedSegmentIndex == 2){
                readDataDS(y: 2)
                Xlabel.text="(月)"
                Ylabel.text="(m/m)"
            }

        }
        
    }
 
    @IBAction func DataChanged(_ sender: AnyObject) {
        if (Flag==0) {
        
        if (DataSelect.selectedSegmentIndex == 0) {
            //最初のセグメントが0。セグメント数に合わせて条件分岐を
            readDataDW(x: 0)
            Xlabel.text="(日)"
            Ylabel.text="(cm)"
        } else if (DataSelect.selectedSegmentIndex == 1) {
            readDataDW(x: 1)
            Xlabel.text="(週)"
            Ylabel.text="(cm)"
        } else if (DataSelect.selectedSegmentIndex == 2){
            readDataDW(x: 2)
            Xlabel.text="(月)"
            Ylabel.text="(cm)"
            }
        }
        else if(Flag==1){
            if (DataSelect.selectedSegmentIndex == 0) {
                //最初のセグメントが0。セグメント数に合わせて条件分岐を
                readDataDS(y: 0)
                Xlabel.text="(日)"
                Ylabel.text="(m/m)"
            } else if (DataSelect.selectedSegmentIndex == 1) {
                readDataDS(y: 1)
                Xlabel.text="(週)"
                Ylabel.text="(m/m)"
            } else if (DataSelect.selectedSegmentIndex == 2){
                readDataDS(y: 2)
                Xlabel.text="(月)"
                Ylabel.text="(m/m)"
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(values: [Double],Data:Int!) {
        
        var dataEntries: [BarChartDataEntry] = []
        
        for (i,val) in values.enumerated() {
            let dataEntry = BarChartDataEntry(x:Double(i),y:val)
            dataEntries.append(dataEntry)
        }
        
        
        let lineChartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = BarChartData(dataSet: lineChartDataSet)
        Graph.data = lineChartData
        
        // X軸のラベルを設定
        let xaxis = XAxis()
        //BarChartFormatter().Datas = Data
        if (Data==1){
            xaxis.valueFormatter = BarChartFormatter_weeks()}
        else if (Data==2) {xaxis.valueFormatter = BarChartFormatter_months()}
        else {xaxis.valueFormatter = BarChartFormatter_years()}
        // グラフの色
        lineChartDataSet.colors = [UIColor(red: 173/255, green: 236/255, blue: 236/255, alpha: 5)]
        Graph.xAxis.valueFormatter = xaxis.valueFormatter
        Graph.xAxis.labelRotatedHeight=CGFloat(30.0)
        Graph.xAxis.labelRotatedWidth=CGFloat(30.0)
        Graph.xAxis.labelFont=UIFont.systemFont(ofSize: 20.0)
        Graph.getAxis(.left).labelFont = UIFont.systemFont(ofSize: 16.0)
        Graph.getAxis(.right).drawLabelsEnabled = false
        Graph.xAxis.labelPosition = .bottom
        // グラフの棒をニョキッとアニメーションさせる
        //Graph.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        //X軸のグリッド線を削除
       Graph.xAxis.drawGridLinesEnabled = false
       Graph.rightAxis.drawGridLinesEnabled = false
       Graph.leftAxis.drawGridLinesEnabled  = false
       Graph.legend.enabled  = false
       //バーの上の数字を非表示
       lineChartData.setDrawValues(false)
        Graph.leftAxis.axisMinimum = 0
        Graph.descriptionText = ""
        Graph.highlightPerTapEnabled = false
        
    }
    
    public class BarChartFormatter_weeks: NSObject, IAxisValueFormatter{
        var weeks: [String]! = ["月", "火", "水", "木", "金", "土", "日", "", "", "", "", ""]// x軸のラベル
        // デリゲート。TableViewのcellForRowAtで、indexで渡されたセルをレンダリングするのに似てる。
        
      public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(value)
            // 0 -> Jan, 1 -> Feb...
            return weeks[Int(value)]
        }
    }
    public class BarChartFormatter_months: NSObject, IAxisValueFormatter{
        // x軸のラベル 
        var months: [String]! = ["1", "2", "3", "4", "5", "", "", "", "", "", "", ""]
        // デリゲート。TableViewのcellForRowAtで、indexで渡されたセルをレンダリングするのに似てる。
        
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            // 0 -> Jan, 1 -> Feb...
            
            return months[Int(value)]
        }
    }
    public class BarChartFormatter_years: NSObject, IAxisValueFormatter{
        // x軸のラベル
         var years: [String]! = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        // デリゲート。TableViewのcellForRowAtで、indexで渡されたセルをレンダリングするのに似てる。
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            // 0 -> Jan, 1 -> Feb..
            return years[Int(value)]
        }
    }
    
    //データの読み出しDW(歩幅)
    func readDataDW(x: Int) {
        // 取得したいデータのタイプを生成.
        let typeOfdistanceWheelchair = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWheelchair)
        
        let calendar = Calendar.init(identifier: Calendar.Identifier.japanese)
        let now = Date()
        
        var DWWeek:[Double] = []
        var DWMonth:[Double] = []
        var DWMonth1 = 0.0
        var DWMonth2 = 0.0
        var DWMonth3 = 0.0
        var DWMonth4 = 0.0
        var DWMonth5 = 0.0
        var DWYear:[Double] = []
        var DWYear1 = 0.0
        var DWYear2 = 0.0
        var DWYear3 = 0.0
        var DWYear4 = 0.0
        var DWYear5 = 0.0
        var DWYear6 = 0.0
        var DWYear7 = 0.0
        var DWYear8 = 0.0
        var DWYear9 = 0.0
        var DWYear10 = 0.0
        var DWYear11 = 0.0
        var DWYear12 = 0.0
        var DW:[Double] = []
        
        // 今日の日付
        var startDate = calendar.startOfDay(for: now)
        startDate = calendar.date(byAdding: Calendar.Component.day, value: 1, to: startDate)!
        
        // 今日から7日までの日付
        let endDate = calendar.date(byAdding: Calendar.Component.day, value: -365, to: startDate)
        let predicate = HKQuery.predicateForSamples(withStart: endDate, end: startDate, options: [])
        
        // データ取得時に登録された時間でソートするためのDescriptorを生成.
        let mySortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        // queryを生成.
        let mySampleQueryDS = HKSampleQuery(sampleType: typeOfdistanceWheelchair!, predicate: predicate, limit: 0, sortDescriptors: [mySortDescriptor])
        { (sampleQuery, results, error ) -> Void in
            
            let cnt = results!.count
            
            for i in 0..<cnt {
                print("\(cnt-i)")
                
                guard let myWeekSample = results![i] as? HKQuantitySample else {
                    print("error")
                    return
                }
                DispatchQueue.main.async {
                    print("歩幅", "\(String(describing: myWeekSample.quantity))")
                    let DWstr = (String(describing: myWeekSample.quantity))
                    let DWstrget = ((DWstr as NSString).substring(to: 3))
                    print(Double(DWstrget)!)
                    DW.append(Double(DWstrget)!*100)
                    
                    //　週間表示
                    if(x == 0){
                        DWWeek.append(Double(DWstrget)!*100)
                        if(i == 6){
                            self.setChart(values: DWWeek, Data: 1)
                        }
                    }
                        
                        //　月間表示
                    else if(x == 1){
                        if(i < 7){
                            DWMonth1 = DWMonth1 + (Double(DWstrget)!*100)
                        }
                        if(i > 6 && i < 14){
                            DWMonth2 = DWMonth2 + (Double(DWstrget)!*100)
                        }
                        if(i > 13 && i < 21){
                            DWMonth3 = DWMonth3 + (Double(DWstrget)!*100)
                        }
                        if(i > 20 && i < 28){
                            DWMonth4 = DWMonth4 + (Double(DWstrget)!*100)
                        }
                        if(i > 27 && i < 32){
                            DWMonth5 = DWMonth5 + (Double(DWstrget)!*100)
                        }
                        if(i == 32){
                            DWWeek.append(DWMonth1/7)
                            DWWeek.append(DWMonth2/7)
                            DWWeek.append(DWMonth3/7)
                            DWWeek.append(DWMonth4/7)
                            DWWeek.append(DWMonth5/4)
                            self.setChart(values: DWWeek, Data: 2)
                        }
                    }
                        
                        //　年間表示
                    else if(x == 2){
                        if(i < 31){
                            DWYear1 = DWYear1 + (Double(DWstrget)!*100)
                        }
                        if(i > 30 && i < 62){
                            DWYear2 = DWYear2 + (Double(DWstrget)!*100)
                        }
                        if(i > 61 && i < 93){
                            DWYear3 = DWYear3 + (Double(DWstrget)!*100)
                        }
                        if(i > 92 && i < 124){
                            DWYear4 = DWYear4 + (Double(DWstrget)!*100)
                        }
                        if(i > 123 && i < 155){
                            DWYear5 = DWYear5 + (Double(DWstrget)!*100)
                        }
                        if(i > 154 && i < 186){
                            DWYear6 = DWYear6 + (Double(DWstrget)!*100)
                        }
                        if(i > 185 && i < 217){
                            DWYear7 = DWYear7 + (Double(DWstrget)!*100)
                        }
                        if(i > 216 && i < 248){
                            DWYear8 = DWYear8 + (Double(DWstrget)!*100)
                        }
                        if(i > 247 && i < 279){
                            DWYear9 = DWYear9 + (Double(DWstrget)!*100)
                        }
                        if(i > 278 && i < 310){
                            DWYear10 = DWYear10 + (Double(DWstrget)!*100)
                        }
                        if(i > 309 && i < 341){
                            DWYear11 = DWYear11 + (Double(DWstrget)!*100)
                        }
                        if(i > 340 && i < 365){
                            DWYear12 = DWYear12 + (Double(DWstrget)!*100)
                        }
                        if(i == 365){
                            DWYear.append(DWYear1/31)
                            DWYear.append(DWYear2/31)
                            DWYear.append(DWYear3/31)
                            DWYear.append(DWYear4/31)
                            DWYear.append(DWYear5/31)
                            DWYear.append(DWYear6/31)
                            DWYear.append(DWYear7/31)
                            DWYear.append(DWYear8/31)
                            DWYear.append(DWYear9/31)
                            DWYear.append(DWYear10/31)
                            DWYear.append(DWYear11/31)
                            DWYear.append(DWYear12/24)
                            self.setChart(values: DWYear, Data: 3)
                        }
                    }
                }
            }
        }
        // queryを発行.
        self.myHealthStore.execute(mySampleQueryDS)
    }

    //データの読み出しDS(歩行速度)
    func readDataDS(y: Int) {
        // 取得したいデータのタイプを生成.
        let typeOfdistanceSwimming = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceSwimming)
        
        let calendar = Calendar.init(identifier: Calendar.Identifier.japanese)
        let now = Date()
        
        var DSWeek:[Double] = []
        var DSMonth:[Double] = []
        var DSMonth1 = 0.0
        var DSMonth2 = 0.0
        var DSMonth3 = 0.0
        var DSMonth4 = 0.0
        var DSMonth5 = 0.0
        var DSYear:[Double] = []
        var DSYear1 = 0.0
        var DSYear2 = 0.0
        var DSYear3 = 0.0
        var DSYear4 = 0.0
        var DSYear5 = 0.0
        var DSYear6 = 0.0
        var DSYear7 = 0.0
        var DSYear8 = 0.0
        var DSYear9 = 0.0
        var DSYear10 = 0.0
        var DSYear11 = 0.0
        var DSYear12 = 0.0
        var DS:[Double] = []
        
        // 今日の日付
        var startDate = calendar.startOfDay(for: now)
        startDate = calendar.date(byAdding: Calendar.Component.day, value: 1, to: startDate)!
        
        // 今日から7日までの日付
        let endDate = calendar.date(byAdding: Calendar.Component.day, value: -365, to: startDate)
        let predicate = HKQuery.predicateForSamples(withStart: endDate, end: startDate, options: [])
        
        // データ取得時に登録された時間でソートするためのDescriptorを生成.
        let mySortDescriptor = NSSortDescriptor(key:HKSampleSortIdentifierStartDate, ascending: false)
        
        // queryを生成.
        let mySampleQueryDS = HKSampleQuery(sampleType: typeOfdistanceSwimming!, predicate: predicate, limit: 0, sortDescriptors: [mySortDescriptor])
        { (sampleQuery, results, error ) -> Void in
            
            let cnt = results!.count
            
            for i in 0..<cnt {
                print("\(cnt-i)")
                
                guard let myWeekSample = results![i] as? HKQuantitySample else {
                    print("error")
                    return
                }
                DispatchQueue.main.async {
                    print("歩行速度", "\(String(describing: myWeekSample.quantity))")
                    let DSstr = (String(describing: myWeekSample.quantity))
                    let DSstrget = ((DSstr as NSString).substring(to: 3))
                    print(Double(DSstrget)!)
                    DS.append(Double(DSstrget)!*100)
                    
                    //　週間表示
                    if(y == 0){
                        DSWeek.append(Double(DSstrget)!*100)
                        if(i == 6){
                            self.setChart(values: DSWeek, Data: 1)
                        }
                    }
                        
                        //　月間表示
                    else if(y == 1){
                        if(i < 7){
                            DSMonth1 = DSMonth1 + (Double(DSstrget)!*100)
                        }
                        if(i > 6 && i < 14){
                            DSMonth2 = DSMonth2 + (Double(DSstrget)!*100)
                        }
                        if(i > 13 && i < 21){
                            DSMonth3 = DSMonth3 + (Double(DSstrget)!*100)
                        }
                        if(i > 20 && i < 28){
                            DSMonth4 = DSMonth4 + (Double(DSstrget)!*100)
                        }
                        if(i > 27 && i < 32){
                            DSMonth5 = DSMonth5 + (Double(DSstrget)!*100)
                        }
                        if(i == 32){
                            DSWeek.append(DSMonth1/7)
                            DSWeek.append(DSMonth2/7)
                            DSWeek.append(DSMonth3/7)
                            DSWeek.append(DSMonth4/7)
                            DSWeek.append(DSMonth5/4)
                            self.setChart(values: DSWeek, Data: 2)
                        }
                    }
                        
                        //　年間表示
                    else if(y == 2){
                        if(i < 31){
                            DSYear1 = DSYear1 + (Double(DSstrget)!*100)
                        }
                        if(i > 30 && i < 62){
                            DSYear2 = DSYear2 + (Double(DSstrget)!*100)
                        }
                        if(i > 61 && i < 93){
                            DSYear3 = DSYear3 + (Double(DSstrget)!*100)
                        }
                        if(i > 92 && i < 124){
                            DSYear4 = DSYear4 + (Double(DSstrget)!*100)
                        }
                        if(i > 123 && i < 155){
                            DSYear5 = DSYear5 + (Double(DSstrget)!*100)
                        }
                        if(i > 154 && i < 186){
                            DSYear6 = DSYear6 + (Double(DSstrget)!*100)
                        }
                        if(i > 185 && i < 217){
                            DSYear7 = DSYear7 + (Double(DSstrget)!*100)
                        }
                        if(i > 216 && i < 248){
                            DSYear8 = DSYear8 + (Double(DSstrget)!*100)
                        }
                        if(i > 247 && i < 279){
                            DSYear9 = DSYear9 + (Double(DSstrget)!*100)
                        }
                        if(i > 278 && i < 310){
                            DSYear10 = DSYear10 + (Double(DSstrget)!*100)
                        }
                        if(i > 309 && i < 341){
                            DSYear11 = DSYear11 + (Double(DSstrget)!*100)
                        }
                        if(i > 340 && i < 365){
                            DSYear12 = DSYear12 + (Double(DSstrget)!*100)
                        }
                        if(i == 365){
                            DSYear.append(DSYear1/31)
                            DSYear.append(DSYear2/31)
                            DSYear.append(DSYear3/31)
                            DSYear.append(DSYear4/31)
                            DSYear.append(DSYear5/31)
                            DSYear.append(DSYear6/31)
                            DSYear.append(DSYear7/31)
                            DSYear.append(DSYear8/31)
                            DSYear.append(DSYear9/31)
                            DSYear.append(DSYear10/31)
                            DSYear.append(DSYear11/31)
                            DSYear.append(DSYear12/24)
                            self.setChart(values: DSYear, Data: 3)
                        }
                    }
                }
            }
        }
        // queryを発行.
        self.myHealthStore.execute(mySampleQueryDS)
    }
}
