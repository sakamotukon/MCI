//
//  ViewController.swift
//  sample1
//
//  Created by pwg on 2016/09/23.
//  Copyright © 2016年 pwg. All rights reserved.
//

import UIKit

class Calc: UIViewController {
    
    /*計算要素*/
    @IBOutlet weak var element1: UILabel!
    @IBOutlet weak var element2: UILabel!
    
    /*回答フォーム*/
    @IBOutlet weak var textfil: UILabel!

    /*計算ボタン*/
  
    @IBOutlet var Buttons: [UIButton]!
    @IBOutlet weak var OKButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet weak var ResultButton: UIButton!
    @IBOutlet weak var EqualLabel: UILabel!
    @IBOutlet weak var PlusLabel: UILabel!
    
    /*合否表示*/
    @IBOutlet weak var check: UILabel!
    
    /*カウントダウンタイマー*/
    @IBOutlet weak var timer: UILabel!//残り時間表示ラベル
    
    /*正解数表示*/
    @IBOutlet weak var Results: UILabel!
    
    
    var current_count = 0//正解回数
    
    var myTimer: Timer!//Timerを使います宣言
    
    var time_counter = 20//初期残り時間
    

    /*タイマーの更新を行う関数*/
    func Ctimer() {
        // ラベルを書き換え
        timer.text = String(time_counter)//ラベルに更新内容を反映
        // カウンターをデクリメント
        time_counter -= 1//毎秒カウントを-1する
        
        if (time_counter == 0){//カウントが0になったら
            for test in Buttons{
                test.isHidden  = true
                
            }
            timer.isHidden = true
            EqualLabel.isHidden = true
            PlusLabel.isHidden=true
            OKButton.isHidden=true
            ResetButton.isHidden=true
            ResultButton.isHidden=false
            element1.isHidden=true
            element2.isHidden=true
            textfil.isHidden=true
            check.isHidden=true
            Results.isHidden=true
            
            
            
            let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.CalcResult = String(current_count)
            /*let nextView=storyboard!.instantiateViewController(withIdentifier: "Target") as! CalcResult
            self.present(nextView, animated: true, completion: nil)*/
            
        }
    }
    
    
    /*初期値0を代入*/
    var n = 0
    var m = 0
    
    //再計算
    /*1〜10までの数字をランダムに代入*/
    func calc(){
    n = Int(arc4random() % 10 + 1)
    m = Int(arc4random() % 10 + 11)
    }
    

    func element(){
        textfil.text = ""
         //テキストフォームを空欄に
        calc()
        element1.text = String(n)//nを文字として代入
        element2.text = String(m)
        //文字として代入
    }
    
    /*Timer処理　一定時間ごとに実行する関数*/
    func Mtimer(){
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(Calc.Ctimer), userInfo: nil, repeats: true)
    }
    

    
    //main
    override func viewDidLoad() {
        super.viewDidLoad()
        /*関数呼び出し*/
        element()
        Mtimer()
        ResultButton.isHidden=true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*ボタンを押した時の処理*/
    @IBAction func calc_bot(_ sender: AnyObject) {
        textfil.text! +=  Buttons[0].currentTitle!
        //ラベルタイトルの値をテキストフォームに代入
    }
    @IBAction func calc_bot2(_ sender: AnyObject) {
        textfil.text! +=  Buttons[1].currentTitle!
    }
    @IBAction func calc_bot3(_ sender: AnyObject) {
        textfil.text! +=  Buttons[2].currentTitle!
    }
    @IBAction func calc_bot4(_ sender: AnyObject) {
        textfil.text! +=  Buttons[3].currentTitle!
    }
    @IBAction func calc_bot5(_ sender: AnyObject) {
        textfil.text! +=  Buttons[4].currentTitle!
    }
    @IBAction func calc_bot６(_ sender: AnyObject) {
        textfil.text! +=  Buttons[5].currentTitle!
    }
    @IBAction func calc_bot7(_ sender: AnyObject) {
        textfil.text! +=  Buttons[6].currentTitle!
    }
    @IBAction func calc_bot8(_ sender: AnyObject) {
        textfil.text! +=  Buttons[7].currentTitle!
    }
    @IBAction func calc_bot9(_ sender: AnyObject) {
        textfil.text! +=  Buttons[8].currentTitle!
    }
    @IBAction func calc_bot0(_ sender: AnyObject) {
        textfil.text! +=  Buttons[9].currentTitle!
    }
    @IBAction func calc_reset(_ sender: AnyObject) {
        textfil.text! =  ""//リセット
    }
    
    
    /*合否判定*/
    @IBAction func comp(_ sender: AnyObject) {//決定
        
        
        
        
        if Int(textfil.text!)! == Int(m)-Int(n){//合否判定の条件
            check.text = "○"//正解なら○
            check.textColor = UIColor.red
            calc()//問題の計算リセット
            element()//計算問題の表示更新
            current_count += 1 //正解回数をインクリメント
            Results.text = "\(current_count)"
            
        }else{
            check.text = "×"//不正解なら×
            check.textColor = UIColor.blue
            textfil.text! =  ""//文字リセット
            Results.text = "\(current_count)"
        }
        
       
    }
    
    //check.text = String(current_count)
    
    
}

