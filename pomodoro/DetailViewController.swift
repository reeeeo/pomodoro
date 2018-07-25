//
//  DetailViewController.swift
//  pomodoro
//
//  Created by Yasuteru on 2018/07/25.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var myTask: UILabel!
    @IBOutlet weak var myDeadLine: UITextField!
    @IBOutlet weak var mycomments: UITextView!
    var datePicker: UIDatePicker = UIDatePicker()
  
    // 詳細画面で表示されるTask
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTask.text = task?.name
        // インプットビュー設定
        datePicker.datePickerMode = .date
        myDeadLine.inputView = datePicker
    }
  
    @IBAction func tapDate(_ sender: UITextField) {
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        myDeadLine.text = "\(formatter.string(from: Date()))"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func tapUpdateButton(_ sender: UIBarButtonItem) {
      
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
