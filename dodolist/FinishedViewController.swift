//
//  FinishedViewController.swift
//  dodolist
//
//  Created by JCR on 2020/04/26.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit
var Completed_filtered = [Todo]()

class FinishedViewController : UITableViewController {
        
    @IBOutlet var finishedTableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Completed_filtered = aList.filter { $0.isComplete == true }
        finishedTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        finishedTableView.delegate = self
        finishedTableView.dataSource = self
    }
    // n번째 섹션의 m번째 row를 그리는데 필요한 cell을 반환하는 메소드입니다
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.finishedTitleLabel?.text = Completed_filtered[indexPath.row].title
        cell.finishedDateLabel?.text = Completed_filtered[indexPath.row].deadline
        cell.finishedTagsLabel?.text = Completed_filtered[indexPath.row].tag
        
//        cell.textLabel?.text = Completed_filtered[indexPath.row].title
//        cell.detailTextLabel?.text = Completed_filtered[indexPath.row].deadline
        if Completed_filtered[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Completed_filtered.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark{
                Completed_filtered[indexPath.row].isComplete = false
                cell.accessoryType = .none
            }
        }
        aList = aList.map { (Todo) -> Todo in
            var Todo = Todo
            if Todo.title == Completed_filtered[indexPath.row].title {
                Todo.isComplete = false
            }
            return Todo
        }
        saveAllData()
        finishedTableView.reloadData()
    }

}
