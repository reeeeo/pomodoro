//
//  DetailViewController.swift
//  pomodoro
//
//  Created by Yasuteru on 2018/07/25.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit
import CoreData

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
        mycomments.text = task?.comment
        // インプットビュー設定
        datePicker.datePickerMode = .date
        myDeadLine.inputView = datePicker
    }
  
    @IBAction func tapDate(_ sender: UITextField) {
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        myDeadLine.text = "\(formatter.string(from: datePicker.date))"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func tapUpdateButton(_ sender: UIBarButtonItem) {
        // coredataの更新処理
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
//        let predicate = NSPredicate(format: "%K = %@", "name", (task?.name)!)
//        fetchRequest.predicate = predicate
//        let fetchData = try! manageContext.fetch(fetchRequest)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ja_JP")
        let date = formatter.date(from: myDeadLine.text!)
        if myDeadLine.text != .none {
            task?.deadLine = date! as NSDate
        }
        task?.comment = mycomments.text
        do{
            try manageContext.save()
        }catch{
            print(error)
        }
        //self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func tapDeleteButton(_ sender: UIBarButtonItem) {
        // coredataの削除処理
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "%K = %@", "name", (task?.name)!)
        fetchRequest.predicate = predicate
        do {
            let fetchResults = try manageContext.fetch(fetchRequest)
            for result: AnyObject in fetchResults {
                let record = result as! NSManagedObject
                manageContext.delete(record)
            }
            try manageContext.save()
        } catch {
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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
