//
//  TodoViewControlloer.swift
//  dodolist
//
//  Created by handongkim on 2020/04/07.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class TodoViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
      super.viewDidLoad()
     
      todoTableView.delegate = self
      todoTableView.dataSource = self
    }
    
    // n번째 섹션의 m번째 row를 그리는데 필요한 cell을 반환하는 메소드입니다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
     
        return cell
    }
     
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBOutlet weak var todoTableView: UITableView!
}
