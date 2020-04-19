//
//  TodoViewControlloer.swift
//  dodolist
//
//  Created by handongkim on 2020/04/07.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

var aList = [Todo]()

class TodoViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var todoTableView: UITableView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      loadAllData()
      todoTableView.delegate = self
      todoTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // n번째 섹션의 m번째 row를 그리는데 필요한 cell을 반환하는 메소드입니다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
       cell.textLabel?.text = aList[indexPath.row].title
       cell.detailTextLabel?.text = aList[indexPath.row].deadline
       if aList[indexPath.row].isComplete {
         cell.accessoryType = .checkmark
       }else{
         cell.accessoryType = .none
       }
        return cell
    }
     
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aList.count
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    func loadAllData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
                return
        }
     
        print(data.description)
        print(data.count)
        // list 배열에 저장하기
        print(type(of: data))
        aList = data.map {
            let title = $0["title"] as? String
            let deadline = $0["deadline"] as? String
            let description = $0["description"] as? String
            let isComplete = $0["isComplete"] as? Bool
     
            return Todo(title: title!, deadline: deadline!, description:description!, isComplete: isComplete!)
        }
    }
}
