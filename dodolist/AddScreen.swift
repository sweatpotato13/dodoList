//
//  ViewController.swift
//  dodolist
//
//  Created by JCR on 2020/04/05.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class AddScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        // TODO : Need to store data to add list
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

