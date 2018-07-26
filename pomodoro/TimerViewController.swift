//
//  TimerViewController.swift
//  pomodoro
//
//  Created by Yasuteru on 2018/07/26.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit
import AudioToolbox

class TimerViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet var mySwipeGesture: UISwipeGestureRecognizer!
    
    var timer : Timer = Timer()
    var count = 5 //25 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
      Timer.scheduledTimer(
        timeInterval: 1,
        target: self,
        selector: #selector(TimerViewController.onUpdate(timer:)),
        userInfo: nil,
        repeats: true)
    }
  
    @objc func onUpdate(timer: Timer) {
        count -= 1
        if count > 0 {
            let (min, sec) = secondsToMinutesSeconds(count)
            myLabel.text = ("\(min):\(sec)")
        } else {
            myLabel.text = "00:00"
            timer.invalidate()
            alert()
        }
    }
    
    func secondsToMinutesSeconds (_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func alert() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        let soundID: SystemSoundID = 1005
        AudioServicesPlaySystemSound(soundID)
        let alert = UIAlertController(title: "お疲れ様でした。", message: "集中できましたか？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true,completion: nil)
    }
    
    @IBAction func tapCancel(_ sender: UIButton) {
       self.presentingViewController?.dismiss(animated: true, completion: nil)
       self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
