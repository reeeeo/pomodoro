//
//  TimerViewController.swift
//  pomodoro
//
//  Created by Yasuteru on 2018/07/26.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    var timer : Timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @objc func countDown(){
        
        let message = appDelegate.message
        var mainasu: Int = Int(message!)
        var keisan = count + mainasu
        
        //カウントを減らす。
        count -= 1
        //カウントダウン状況をラベルに表示
        if(keisan > 0) {
            testLabel.text = "残り\(keisan)秒です。"//ここをいじるはず分ラベルと秒ラベルで操作?
            //            print(count,message,keisan)
            //        } else if (keisan < 0) {
            //            appDelegate.message = 0
            //            testLabel.text = "あああ"
            //            timer.invalidate()
            //            Hikari()
            //}
        }else {
            testLabel.text = "おはようございます!"
            timer.invalidate()
            //光らせる
            Hikari()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
