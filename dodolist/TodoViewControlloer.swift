//
//  TodoViewControlloer.swift
//  dodolist
//
//  Created by handongkim on 2020/04/07.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class TodoViewController : UITableViewController {
    
    var dataset = [
        ("설정창 수정", "2020-04-18", "3주차 1", "feature", "1"),
        ("todolist 수정", "2020-04-18", "3주차 2", "feature", "2"),
        ("탭바 설정", "2020-04-18", "3주차 3", "feature", "3")
    ]
    
    lazy var list: [TestTodos] = {
        var datalist = [TestTodos]()
        
        for(title, date, desc, tags, priority) in self.dataset {
            let todo = TestTodos()
            todo.title = title
            todo.date = date
            todo.description = desc
            todo.tags = tags
            todo.priority = priority
            datalist.append(todo)
        }
        return datalist
    }()
    
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
        
       cell.textLabel?.text = list[indexPath.row].title
       cell.detailTextLabel?.text = list[indexPath.row].deadline
       if list[indexPath.row].isComplete {
         cell.accessoryType = .checkmark
       }else{
         cell.accessoryType = .none
       }
        return cell
    }
     
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        cell.textLabel?.text = row.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    
    @IBOutlet weak var todoTableView: UITableView!

    func loadAllData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
                return
        }
     
        print(data.description)
     
        // list 배열에 저장하기
        print(type(of: data))
        list = data.map {
            let title = $0["title"] as? String
            let deadline = $0["deadline"] as? String
            let description = $0["description"] as? String
            let isComplete = $0["isComplete"] as? Bool
     
            return Todo(title: title!, deadline: deadline!, description:description!, isComplete: isComplete!)
        }
    }
}
