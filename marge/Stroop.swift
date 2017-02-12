//
//  ViewController.swift
//  ShingoHaNaniiro
//
//  Created by pwg on 2016/08/21.
//  Copyright © 2016年 RainbowApps. All rights reserved.
//

import UIKit

class Stroop: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var ColorWord: UILabel!
    
    @IBOutlet weak var Seikai: UILabel!
    @IBOutlet weak var Seigen: UILabel!
    @IBOutlet weak var CountDown: UILabel!
    
    @IBOutlet weak var ResultBtn: UIButton!
    @IBOutlet weak var RedButton: UIButton!
    @IBOutlet weak var BlueButton: UIButton!
    @IBOutlet weak var GreenButton: UIButton!
    @IBOutlet weak var YellowButton: UIButton!
    var text:Int = 0
    
    var timer:Timer!
    var cnt:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResultBtn.isHidden=true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountUp.Down(_:)), userInfo: nil, repeats: true)

        
        ColorWord.text="きいろ"
        ColorWord.textColor=UIColor.blue
        text=2
        
    }
    
    func Down(_ timer : Timer){
        cnt += 1
        let count = 30-cnt
        CountDown.text = String(count)
        if ( count==0 ) {
            timer.invalidate()
            Seigen.isHidden=true
            Seikai.isHidden=true
            CountDown.isHidden=true
            resultLabel.isHidden=true
            ColorWord.isHidden=true
            
            RedButton.isHidden=true
            BlueButton.isHidden=true
            YellowButton.isHidden=true
            GreenButton.isHidden=true
            
            ResultBtn.isHidden=false
                
            }
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.StroopResult = resultLabel.text
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomSignal(){
        
        //ランダムな単語と色を作る
        let randomColor = arc4random()%4
        let randomWord = arc4random()%4
        
        //0:1:赤2:青3:黄色　それ以外緑
        if randomWord == 0{
            ColorWord.text="あか"
            text=1
        }else if randomWord==1{
            ColorWord.text="あお"
            text=0
            
        }else if randomWord==2{
            ColorWord.text="きいろ"
            text=2
        }else if randomWord==3{
            ColorWord.text="みどり"
            text=3
        }
        
        //ランダムに色を加える 0:あか1:あお2:きいろ　それ以外みどり
        if randomColor == 0{
            ColorWord.textColor = UIColor.red
        }else if randomColor==1{
            ColorWord.textColor = UIColor.blue
            
        }else if randomColor==2{
            ColorWord.textColor = UIColor.yellow
        }else if randomColor==3{
            ColorWord.textColor = UIColor.green
        }
        
        
    }

    @IBAction func blueBtnPushed(_ sender: AnyObject) {
        
        
        if text == BlueButton.tag{
            resultLabel.text = String(Int(resultLabel.text!)!+1)
        }
        //ランダム実行
        randomSignal()
    }
    

   
    @IBAction func yellowBtnPushed(_ sender: AnyObject) {
       
        
        if text == YellowButton.tag{
           resultLabel.text = String(Int(resultLabel.text!)!+1)
        }
        //ランダム実行
        randomSignal()

    }
    
    @IBAction func redBtnPushed(_ sender: AnyObject) {
       
    
        
        if  text == RedButton.tag{
            resultLabel.text = String(Int(resultLabel.text!)!+1)
        }
        //ランダム実行
        randomSignal()
    }
    
    @IBAction func greenBtnPushed(_ sender: AnyObject) {
      
        if  text == GreenButton.tag{
            resultLabel.text = String(Int(resultLabel.text!)!+1)
        }
        //ランダム実行
        randomSignal()
    }

    
}

