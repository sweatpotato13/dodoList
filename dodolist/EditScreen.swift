//
//  EditScreen.swift
//  dodolist
//
//  Created by mac on 2020/05/01.
//  Copyright © 2020 dodo. All rights reserved.
//

import Foundation
import UIKit
class EditScreen: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var index = 0
    @IBOutlet weak var pvPriority: UIPickerView!
    @IBOutlet weak var pvTag: UIPickerView!
    @IBOutlet weak var dpShowDate: UIDatePicker!
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPriority: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var tfDesc: UITextField!
    
    private func getIndex(){
        for i in 0...aList.count{
            if (aList[i].title == clickedTitle){
                index = i
                break
            }
        }
    }
    private func loadExistData(){
        tfTitle.text = aList[index].title
        lblDate.text = aList[index].deadline
        lblPriority.text = aList[index].priority
        lblTag.text = aList[index].tag
        tfDesc.text = aList[index].description
    }
    @IBAction func dpDataAction(_ sender: Any) {
        dpShowDateChanged()
    }
    
    private func dpShowDateChanged () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        self.lblDate.text = dateFormatter.string(from: dpShowDate.date)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
        pvPriority.dataSource = self
        pvPriority.delegate = self
        pvTag.dataSource = self
        pvTag.delegate = self
        pvPriority.tag = 1
        pvTag.tag = 2;
        getIndex()
        loadExistData()
    }
}
