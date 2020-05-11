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
    
    let ad = UIApplication.shared.delegate as? AppDelegate
        
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
        
        let titleLabel = cell.finishedTitleLabel
        let dateLabel = cell.finishedDateLabel
        let tagsLabel = cell.finishedTagsLabel
        
        titleLabel?.text = Completed_filtered[indexPath.row].title
        dateLabel?.text = Completed_filtered[indexPath.row].deadline
        tagsLabel?.text = Completed_filtered[indexPath.row].tag
        
        setFontSize(ad: ad, titleLabel, dateLabel, tagsLabel)
        
        if Completed_filtered[indexPath.row].isComplete {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    private func removeData(index: Int){
        aList.remove(at: index)
    }
    
    private func getIndex() -> Int{
        for i in 0...aList.count{
            if (aList[i].title == swipedTitle){
                return i;
            }
        }
        return -1
    }

    public override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView.cellForRow(at: indexPath) != nil{
            swipedTitle = Completed_filtered[indexPath.row].title!
        }
        let idx = getIndex()
        print(aList[idx])
        let edit = UIContextualAction(style: .normal, title: "Edit"){
            action, view, completion in completion(true)
            if tableView.cellForRow(at: indexPath) != nil{
                clickedTitle = Completed_filtered[indexPath.row].title!
            }
            self.performSegue(withIdentifier: "EditScreen", sender: nil)
        }

        let complete = UIContextualAction(style: .normal, title: "Not Complete"){
            action, view, completion in completion(true)
            aList[idx].isComplete = false
            saveAllData()
        }
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") {
            action, view, completion in completion(true)
            self.removeData(index: idx);
            saveAllData()
        }
        
        edit.backgroundColor = UIColor.black
        return UISwipeActionsConfiguration(actions: [delete, edit, complete])
    }

    
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Completed_filtered.count
    }
}
