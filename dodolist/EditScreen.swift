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
    @IBOutlet weak var swComplete: UISwitch!
    
    func setDefaultValue(){
        if let indexPosition = PriorityValues.firstIndex(of: lblPriority.text ?? "Mid"){
            pvPriority.selectRow(indexPosition, inComponent: 0, animated: true)
        }
        if let indexPosition = TagValues.firstIndex(of: lblTag.text ?? "None"){
            pvTag.selectRow(indexPosition, inComponent: 0, animated: true)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let date = dateFormatter.date(from: lblDate.text ?? "")
        dpShowDate.date = date!
    }
    
    private func editData(index: Int){
        aList[index].title = tfTitle.text
        aList[index].deadline = lblDate.text
        aList[index].priority = lblPriority.text ?? "Mid"
        aList[index].tag = lblTag.text ?? "None"
        aList[index].description = tfDesc.text ?? ""
        aList[index].isComplete = swComplete.isOn
    }
    
    private func removeData(index: Int){
        aList.remove(at: index)
    }
    
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
        swComplete.isOn = aList[index].isComplete
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        editData(index: index)
        saveAllData()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnRemove(_ sender: Any) {
        removeData(index: index)
        saveAllData()
        self.navigationController?.popViewController(animated: true)
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,
                    inComponent component: Int) {
        if pickerView == pvPriority {
            lblPriority.text = PriorityValues[row]
        } else if pickerView == pvTag{
            lblTag.text = TagValues[row]
        }
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
        setDefaultValue()
    }
}
