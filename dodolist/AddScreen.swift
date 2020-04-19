//
//  ViewController.swift
//  dodolist
//
//  Created by JCR on 2020/04/05.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class AddScreen: UIViewController {
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTxt.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        // Do any additional setup after loading the view.
    }
    @IBAction func addListItemAction() {
     
        let title = titleTxt.text!
        let deadline = dateTxt.text ?? ""
        let description = descTxt.text ?? ""
        let item: Todo = Todo(title: title, deadline: deadline, description: description)
        // TodoListViewController에 생성한 전역변수에 append
        list.append(item)
    }
    @objc func doneButtonPressed() {
       if let  datePicker = self.dateTxt.inputView as? UIDatePicker {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .medium
           self.dateTxt.text = dateFormatter.string(from: datePicker.date)
       }
       self.dateTxt.resignFirstResponder()
    }

    @IBAction func btnAdd(_ sender: Any) {
        addListItemAction()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        saveAllData()
        // TODO : Need to store data to add list
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        saveAllData()
    }
    func saveAllData() {
        let data = list.map {
            [
                "title": $0.title,
                "deadline": $0.deadline!,
                "description": $0.description!,
                "isComplete": $0.isComplete

            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items") // 키, value 설정
        userDefaults.synchronize()  // 동기화
    }
}

 extension UITextField {

   func addInputViewDatePicker(target: Any, selector: Selector) {

    let screenWidth = UIScreen.main.bounds.width

    //Add DatePicker as inputView
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
    datePicker.datePickerMode = .date
    self.inputView = datePicker

    //Add Tool Bar as input AccessoryView
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
    let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
    toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

    self.inputAccessoryView = toolBar
 }

   @objc func cancelPressed() {
     self.resignFirstResponder()
   }
}
