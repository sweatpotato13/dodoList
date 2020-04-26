//
//  TodoViewControlloer.swift
//  dodolist
//
//  Created by handongkim on 2020/04/07.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

var aList = [Todo]()
var notComplete_filtered = [Todo]()
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
        let priority = $0["priority"] as? String
        let tag = $0["tag"] as? String
        
        return Todo(title: title!, deadline: deadline!, description:description!, isComplete: isComplete!, priority: priority!, tag: tag!)
    }
}

class TodoViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var todoTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notComplete_filtered = aList.filter { $0.isComplete == false }
        todoTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllData()
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }
    
    // n번째 섹션의 m번째 row를 그리는데 필요한 cell을 반환하는 메소드입니다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = notComplete_filtered[indexPath.row].title
        cell.detailTextLabel?.text = notComplete_filtered[indexPath.row].deadline
        if notComplete_filtered[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none{
                notComplete_filtered[indexPath.row].isComplete = true
                cell.accessoryType = .checkmark
            }
        }
        aList = aList.map { (Todo) -> Todo in
            var Todo = Todo
            if Todo.title == notComplete_filtered[indexPath.row].title {
                Todo.isComplete = true
            }
            return Todo
        }
        saveAllData()
        todoTableView.reloadData()
    }
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notComplete_filtered.count
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
