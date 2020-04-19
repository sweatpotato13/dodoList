//
//  ViewController.swift
//  dodolist
//
//  Created by JCR on 2020/04/05.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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

    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.list.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let row = self.list[indexPath.row]
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "todo")!
//        cell.textLabel?.text = row.title
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
//    }
}

