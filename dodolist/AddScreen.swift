//
//  TestScreen.swift
//  dodolist
//
//  Created by JCR on 2020/04/25.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class AddScreen: UITableViewController {
    private var dpShowDateVisible = false
    @IBOutlet weak var lblShowData: UILabel!
    @IBOutlet weak var dpShowDate: UIDatePicker!
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBAction func dpShowDateAction(_ sender: UIDatePicker) {
        
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        addListItemAction()
        saveAllData()
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    @IBAction func addListItemAction() {
     
        let title = titleTxt.text!
        let deadline = lblShowData.text ?? ""
        let description = descTxt.text ?? ""
        let priority = "low"
        let item: Todo = Todo(title: title, deadline: deadline, description: description, priority: priority)
        // TodoListViewController에 생성한 전역변수에 append
        aList.append(item)
    }
    func saveAllData() {
        let data = aList.map {
            [
                "title": $0.title,
                "deadline": $0.deadline!,
                "description": $0.description!,
                "isComplete": $0.isComplete,
                "priority": $0.priority
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items") // 키, value 설정
        userDefaults.synchronize()  // 동기화
    }

    private func toggleShowDateDatepicker () {
         dpShowDateVisible = !dpShowDateVisible

         tableView.beginUpdates()
         tableView.endUpdates()
    }
    private func dpShowDateChanged () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        self.lblShowData.text = dateFormatter.string(from: dpShowDate.date)

    }
    
    @IBAction func dpShowDataAction(_ sender: UIDatePicker) {
        dpShowDateChanged()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         if indexPath.row == 0 {
              toggleShowDateDatepicker()
         }

        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
     func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         if !dpShowDateVisible && indexPath.row == 1 {
              return 0
         } else {
            return super.tableView.rowHeight
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

}
