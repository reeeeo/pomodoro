//
//  TimerViewController.swift
//  pomodoro
//
//  Created by Yasuteru on 2018/07/26.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet var mySwipeGesture: UISwipeGestureRecognizer!
    
    var timer : Timer = Timer()
    var count = 25 * 60
    
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
        }
    }
    
  
    func secondsToMinutesSeconds (_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @IBAction func tapCancel(_ sender: UIButton) {
       self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
