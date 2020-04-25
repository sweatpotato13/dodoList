//
//  TestScreen.swift
//  dodolist
//
//  Created by JCR on 2020/04/25.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit
private let PriorityValues: [String] = ["High","Mid","Low"]
private let TagValues: [String] = ["None","Home","School","Work"]

class AddScreen: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var lblShowData: UILabel!
    @IBOutlet weak var dpShowDate: UIDatePicker!
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var priorityText: UILabel!
    @IBOutlet weak var tagText: UILabel!
    @IBOutlet weak var pvPriority: UIPickerView!
    @IBOutlet weak var pvTag: UIPickerView!
    @IBAction func dpShowDateAction(_ sender: UIDatePicker) {
        
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        addListItemAction()
        saveAllData()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addListItemAction() {
     
        let title = titleTxt.text!
        let deadline = lblShowData.text ?? ""
        let description = descTxt.text ?? ""
        let priority = priorityText.text ?? "Mid"
        let tag = tagText.text ?? "None"
        let item: Todo = Todo(title: title, deadline: deadline, description: description, priority: priority, tag: tag)
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
                "priority": $0.priority,
                "tag":$0.tag
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items") // 키, value 설정
        userDefaults.synchronize()  // 동기화
    }

    private func dpShowDateChanged () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        self.lblShowData.text = dateFormatter.string(from: dpShowDate.date)
    }
    
    @IBAction func dpShowDataAction(_ sender: UIDatePicker) {
        dpShowDateChanged()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
        pvPriority.dataSource = self
        pvPriority.delegate = self
        pvTag.dataSource = self
        pvTag.delegate = self
        pvPriority.tag = 1
        pvTag.tag = 2;

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pvPriority {
            return PriorityValues.count

        } else if pickerView == pvTag{
             return TagValues.count
        }

        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pvPriority {
            return PriorityValues[row]

        } else if pickerView == pvTag{
             return TagValues[row]
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
    inComponent component: Int) {
        if pickerView == pvPriority {
            priorityText.text = PriorityValues[row]
        } else if pickerView == pvTag{
            tagText.text = TagValues[row]
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
}
