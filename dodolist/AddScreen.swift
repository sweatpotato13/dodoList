//
//  ViewController.swift
//  dodolist
//
//  Created by JCR on 2020/04/05.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class AddScreen: UIViewController {
    
    var TextFieldName : UITextField!
    @IBOutlet weak var tfDeadLine: UITextField!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        // TODO : Need to store data to add list
    }
    @IBAction func DeadLine_onClick(_ sender: Any) {
        TextFieldName = tfDeadLine
        CreateDatePicker()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func CreateDatePicker() {
        //format for picker
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        TextFieldName.inputAccessoryView = toolbar
        
        //assigning date picker to text field
        TextFieldName.inputView = datePicker
        
    }
    @objc func donePressed(_ sender : Any) {
        //format date
        print(TextFieldName)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        TextFieldName.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

}

