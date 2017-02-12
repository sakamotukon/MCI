//
//  ViewController.swift
//  CountUp
//
//  Created by pwg on 2016/09/23.
//  Copyright © 2016年 MedicalProject. All rights reserved.
//

import UIKit


class CountUp: UIViewController {
    
    //カウント初期化
    var cnt : Int = 0
    //透明度
    let cre = 0.3
    //変数宣言
    var timer : Timer!
    var Number=Array(repeating: 0, count: 9)
    var k:Int=0
  
    
    //ストーリーボード宣言
    
    @IBOutlet weak var CountDown: UILabel!
    @IBOutlet var Buttons: [UIButton]!
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var ResultButton: UIButton!
    @IBOutlet weak var Seigen: UILabel!
    @IBOutlet weak var Seikai: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
       //30秒からカウントダウン開始
        CountDown.text = "30"
        //初期点数セット
        ResultLabel.text = "0"
        //timerの間隔、繰り返し、実行メソッド指定
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountUp.Down(_:)), userInfo: nil, repeats: true)
        ResultButton.isHidden = true
        setNumber()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //カウントダウンタイマー
    func Down(_ timer : Timer){
        cnt += 1
        let count = 30-cnt
        CountDown.text = String(count)
        if ( count==0 ) {
            timer.invalidate()
            Seigen.isHidden = true
            Seikai.isHidden = true
            CountDown.isHidden = true
            ResultLabel.isHidden = true
            ResultButton.isHidden  = false
            for test in Buttons{
                test.isHidden  = true
            
            }
            
            
            
            
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.message = ResultLabel.text
            
            
            // nextView = storyboard!.instantiateViewController(withIdentifier: "Result") as! ResultViewController
            //self.present(nextView, animated: true, completion: nil)
            
            
        }
    }
    
    func PushJudge(_ PushNumber:Int){
        
            if (PushNumber == Number[k]){
                k=k+1
                if(k==Buttons.count) {
                    ResetGame()
                    ResultLabel.text = String(Int(ResultLabel.text!)!+1)
                }
            }else{
                ResetGame()
        }
    }
    
    func Buttonalpha (_ sender:UIButton){
        sender.isEnabled=false
        sender.alpha = 0.3
    }
    
    @IBAction func Button1(_ sender: AnyObject) {
        Buttonalpha(Buttons[0])
        PushJudge(Int(Buttons[0].currentTitle!)!)
    }
    @IBAction func Button2(_ sender: AnyObject) {
        Buttonalpha(Buttons[1])
        PushJudge(Int(Buttons[1].currentTitle!)!)
    }
    @IBAction func Button3(_ sender: AnyObject) {
        Buttonalpha(Buttons[2])
        PushJudge(Int(Buttons[2].currentTitle!)!)

    }
    @IBAction func Button4(_ sender: AnyObject) {
        Buttonalpha(Buttons[3])
        PushJudge(Int(Buttons[3].currentTitle!)!)

    }
    @IBAction func Button5(_ sender: AnyObject) {
        Buttonalpha(Buttons[4])
        PushJudge(Int(Buttons[4].currentTitle!)!)
    }
    @IBAction func Button6(_ sender: AnyObject) {
        Buttonalpha(Buttons[5])
        PushJudge(Int(Buttons[5].currentTitle!)!)
    }
    @IBAction func Button7(_ sender: AnyObject) {
        Buttonalpha(Buttons[6])
        PushJudge(Int(Buttons[6].currentTitle!)!)

    }
    @IBAction func Button8(_ sender: AnyObject) {
        Buttonalpha(Buttons[7])
        PushJudge(Int(Buttons[7].currentTitle!)!)

    }
    @IBAction func Button9(_ sender: AnyObject) {
        Buttonalpha(Buttons[8])
        PushJudge(Int(Buttons[8].currentTitle!)!)

    }
    
    fileprivate func setNumber (){
        var k:Int=0
        var temp:Int = 0
        //最初のボタンにランダム数字を代入
        for i in 0..<Buttons.count {
            Buttons[i].setTitle(String(arc4random()%50), for: UIControlState())
            k=0
            while (k<i){
                if(Buttons[k].currentTitle==Buttons[i].currentTitle){
                    Buttons[i].setTitle(String(arc4random()%50), for: UIControlState())
                    k=0
                }
            
            k=k+1
            }
         Number[i]=Int(Buttons[i].currentTitle!)!
         print(Number[i])
         
        
        }
        for i in 0..<Buttons.count-1{ //最初からn-2まで順に確定する
            for j in (i+1..<Buttons.count).reversed(){      //最後からi+1まで順に小さいのを押し出す
                if(Number[j-1]>Number[j]){     //もし後ろの要素a[j]が小さいなら交換
                    temp = Number[j-1]; //一時保存
                    Number[j-1]=Number[j];     //a[j-1]とa[j]を交換
                    Number[j]=temp;
                }
            }
        }
        for i in 0..<Buttons.count {
            print(Number[i])
        }
    }

    func ResetGame (){
        setNumber()
        k=0
        for i in 0..<Buttons.count{
            Buttons[i].isEnabled = true
            Buttons[i].alpha  = 1
        }
   
    }

}
