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
     
//      todoTableView.delegate = self
//      todoTableView.dataSource = self
    }
    
    // n번째 섹션의 m번째 row를 그리는데 필요한 cell을 반환하는 메소드입니다
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//
//        return cell
//    }
     
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
    
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
}
