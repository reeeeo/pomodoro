//
//  ViewController.swift
//  pomodoro
//
//  Created by okumura reo on 2018/07/25.
//  Copyright © 2018年 reo. All rights reserved.
//

import UIKit
import CoreData
var tasks:[Task] = []

class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        myTableView.delegate = self
        myTableView.dataSource = self
  }
   
    override func viewWillAppear(_ animated: Bool) {
        // CoreDataからデータをfetchしてくる
        getData()
        // taskTableViewを再読み込みする
        myTableView.reloadData()
    }
    
    func getData() {
        // データ保存時と同様にcontextを定義
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            // CoreDataからデータをfetchしてtasksに格納
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            tasks = try context.fetch(fetchRequest)
        } catch {
            print("Fetching Failed.")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskLabel", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        return cell
    }
    var selectedTask:Task?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = tasks[indexPath.row]
        performSegue(withIdentifier: "segueDV", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // coredataの削除処理
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let manageContext = appDelegate.persistentContainer.viewContext
            let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
            let predicate = NSPredicate(format: "%K = %@", "name", (tasks[indexPath.row].name)!)
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
            tasks.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func buttonYapped(_ sender: UIBarButtonItem) {
        showTextInputAlert()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dc:DetailViewController = segue.destination as! DetailViewController
      // print(selectedTask)
        dc.task = selectedTask
    }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
    // テキストフィールド付きアラート表示
    func showTextInputAlert() {
        let alert = UIAlertController(title: "タスク名を入力してください", message: "", preferredStyle: .alert)
        // OKボタンの設定
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            // OKを押した時入力されていたテキストを表示
            if let textFields = alert.textFields {
                // アラートに含まれるすべてのテキストフィールドを調べる
                for textField in textFields {
                    // print(textField.text!)
                    // create処理
                    // AppDelegateのインスタンス化
                    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    let manageContext = appDelegate.persistentContainer.viewContext
                    // エンティティ
                    let task = NSEntityDescription.entity(forEntityName: "Task", in: manageContext)
                    // contextにレコード追加
                    let newRecord = NSManagedObject(entity: task!, insertInto: manageContext)
                    // レコードに値の設定
                    newRecord.setValue(textField.text!, forKey: "name")
                    do {
                        try manageContext.save() // throwはdo catch とセットで使う
                        self.getData()
                        // TableViewを再読み込み.
                        self.myTableView.reloadData()
                    } catch {
                        print("error:",error) // catchとセットで使う
                    }
                }
            }
        })
        alert.addAction(okAction)
        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        // テキストフィールドを追加
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = "空白は避け固有の名前をつけてください"
        })
        alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
        
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
    }
  
  @IBAction func exitView(segue:UIStoryboardSegue) {}
    

}

