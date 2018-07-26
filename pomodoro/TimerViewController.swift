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
    
    var timer : Timer!
    var count = 25 * 60
//    var count = 5
  
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(TimerViewController.onUpdate(timer:)),
            userInfo: nil,
            repeats: true)
        timer.fire()
    }
  
    @objc func onUpdate(timer: Timer) {
        count -= 1
        if count > 0 {
            let (min, sec) = secondsToMinutesSeconds(count)
            myLabel.text = ("\(addZero(min)):\(addZero(sec))")
        } else {
            myLabel.text = "00:00"
            timer.invalidate()
            alert()
        }
    }
    
    func secondsToMinutesSeconds (_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
  
    func addZero(_ val: Int) -> String {
        return val < 10 ? "0" + String(val) : String(val)
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
        timer.invalidate()
        performSegue(withIdentifier: "segueTop", sender: nil)
//       self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
