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
    
    // 설정값을 가져오기 위한 AppDelegate 객체 선언
    // TODO :: 뷰가 불려질 때로 위치 이동 필요
    let ad = UIApplication.shared.delegate as? AppDelegate

    @IBOutlet var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllData()
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }

    // 여기서 호출하면 값을 불러올 수 있다!
    override func viewWillAppear(_ animated: Bool) {
        print("글자 크기 : \(String(describing: ad?.fontSize))")
        print("알람 : \(String(describing: ad?.alarm))")
        print("다크 모드 : \(String(describing: ad?.darkMode))")
        print("잠금 : \(String(describing: ad?.lock))")
        todoTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        todoTableView.reloadData()
    }
    
    @IBAction func settingSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "SettingSegue", sender: self)
    }
    
    // n번째 섹션의 m번째 row를 그리는데 필요한 cell을 반환하는 메소드입니다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as! TableViewCell 구문을 통해 커스텀 테이블 셀의 값을 가져와서  데이터를 넣어줄 수 있다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let titleLabel = cell.titleLabel
        let dateLabel = cell.dateLabel
        let tagsLabel = cell.tagsLabel
        
        titleLabel?.text = aList[indexPath.row].title
        dateLabel?.text = aList[indexPath.row].deadline
        
        // setting 반영
        // 폰트 사이즈 결정
        var cellFontSize = UIFont.systemFont(ofSize: 17)
        // 텍스트 설정
        let titleText = NSMutableAttributedString(string: (titleLabel?.text!)!)
        let dateText = NSMutableAttributedString(string: (dateLabel?.text!)!)
        let tagsText = NSMutableAttributedString(string: (tagsLabel?.text!)!)
        
        if(ad?.fontSize == "Large") {
            cellFontSize = UIFont.systemFont(ofSize: 25)
            titleText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (titleLabel?.text!.count)!))
            dateText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (dateLabel?.text!.count)!))
            tagsText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (tagsLabel?.text!.count)!))
            titleLabel?.attributedText = titleText
            dateLabel?.attributedText = dateText
            tagsLabel?.attributedText = tagsText
        } else if(ad?.fontSize == "Medium") {
            cellFontSize = UIFont.systemFont(ofSize: 17)
            titleText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (titleLabel?.text!.count)!))
            dateText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (dateLabel?.text!.count)!))
            tagsText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (tagsLabel?.text!.count)!))
            titleLabel?.attributedText = titleText
            dateLabel?.attributedText = dateText
            tagsLabel?.attributedText = tagsText
        } else {
            cellFontSize = UIFont.systemFont(ofSize: 9)
            titleText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (titleLabel?.text!.count)!))
            dateText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (dateLabel?.text!.count)!))
            tagsText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: cellFontSize, range: NSMakeRange(0, (tagsLabel?.text!.count)!))
            titleLabel?.attributedText = titleText
            dateLabel?.attributedText = dateText
            tagsLabel?.attributedText = tagsText
        }
        
//        cell.textLabel?.text = aList[indexPath.row].title
//        cell.detailTextLabel?.text = aList[indexPath.row].deadline
        
        //        var fontSizeSetted = UIFont.systemFont(ofSize: 17)
        //        var fontSizeText = NSMutableAttributedString(string: fontSizeLabel.text!)
        //        if(ad?.fontSize == "Large") {
        //            fontSizeSetted = UIFont.systemFont(ofSize: 25)
        //            fontSizeText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSizeSetted, range: NSMakeRange(0, 9))
        //            fontSizeLabel.attributedText = fontSizeText
        //        } else if(ad?.fontSize == "Medium") {
        //            fontSizeSetted = UIFont.systemFont(ofSize: 17)
        //            fontSizeText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSizeSetted, range: NSMakeRange(0, 9))
        //            fontSizeLabel.attributedText = fontSizeText
        //        } else {
        //            fontSizeSetted = UIFont.systemFont(ofSize:9)
        //            fontSizeText.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String), value: fontSizeSetted, range: NSMakeRange(0, 9))
        //            fontSizeLabel.attributedText = fontSizeText
        //        }
        
        
        if aList[indexPath.row].isComplete {
         cell.accessoryType = .checkmark
        } else{
         cell.accessoryType = .none
        }
        return cell
    }
     
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aList.count
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
