//
//  AppSetting.swift
//  marge
//
//  Created by pwg on 2016/12/01.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import Foundation

class AppSetting {
    static let ud = UserDefaults.standard
    
    // set default settings here
    private struct Default {
      //  static let name: String = "Swift Taro"
        static let Stroop: Int = 0
        static let Calc:Int = 0
        static let CountUp:Int = 0
    }
    
    // computed properties as class variables
    class var Stroop: Int {
        get {
            ud.register(defaults: ["Stroop": Default.Stroop])
            return ud.object(forKey: "Stroop") as! Int
        }
        set(newValue) {
            ud.set(newValue, forKey: "Stroop")
            ud.synchronize()
        }
    }
    
    class var Calc: Int {
        get {
            ud.register(defaults: ["Calc": Default.Calc])
            return ud.object(forKey: "Calc") as! Int
        }
        set(newValue) {
            ud.set(newValue, forKey: "Calc")
            ud.synchronize()
        }
    }
    
    class var CountUp: Int {
        get {
            ud.register(defaults: ["CountUp": Default.CountUp])
            return ud.object(forKey: "CountUp") as! Int
        }
        set(newValue) {
            ud.set(newValue, forKey: "CountUp")
            ud.synchronize()
        }
    }

}
