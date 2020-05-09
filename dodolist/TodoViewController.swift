//
//  TodoViewControlloer.swift
//  dodolist
//
//  Created by handongkim on 2020/04/07.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit
import LocalAuthentication

var aList = [Todo]()
var notComplete_filtered = [Todo]()
var clickedTitle = ""
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

func setFontSize(ad: AppDelegate!, _ titleLabel: UILabel!, _ dateLabel: UILabel!, _ tagsLabel: UILabel!) {
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
}

class TodoViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {

    // 설정값을 가져오기 위한 AppDelegate 객체 선언
    let ad = UIApplication.shared.delegate as? AppDelegate
  
    @IBOutlet var todoTableView: UITableView!
    
    func setNotificationTrigger(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if((ad?.alarm) != nil) {
            for i in 0...notComplete_filtered.count-1{
                let date = dateFormatter.date(from: notComplete_filtered[i].deadline ?? "")
                ad?.showEduNotification(date: date!)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notComplete_filtered = aList.filter { $0.isComplete == false }
        todoTableView.reloadData()
        setNotificationTrigger()
    }
    
    @IBAction func settingSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "SettingSegue", sender: self)
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllData()
        todoTableView.delegate = self
        todoTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if((ad?.pass) == false) {

            let authContext = LAContext()

            var error: NSError?
            
            let description: String?

            if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "잠금모드, 인증 필요", reply: { success, error in
                    // 이걸 while success로 바꾼다?
                    while(success) {
                    if success {
                        // Fingerprint recognized
                        self.ad?.pass = true
                        // 네비게이션 뷰 컨트롤러에 생성해보자.
                        // 안되면 별도의 뷰를 생성해야 할 것 같다.
                        DispatchQueue.main.async{
                            print("Authentication success by the system")
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let homeVC = storyBoard.instantiateViewController(withIdentifier: "Main")
                            self.navigationController?.pushViewController(homeVC, animated: true)
                        }
                        break
                    } else {
                        if let err = error {
                            print(err.localizedDescription)
                            // TODO ::
                            // 취소 버튼 누를 때 앱을 바로 이용할 수 있음.
                            // 페이스 인증 실패 후 다시 인증하면 이 부분을 동작하는데 앱이 꺼지게 됨.
                        }
                    }
                }})
            } else {
                let errorDescription = error?.userInfo["NSLocalizedDescription"] ?? ""
                print(errorDescription)
                description = "계정 정보를 열람하기 위해서는 로그인하십시오."

                let alertController = UIAlertController(title: "Authentication Required", message: description, preferredStyle: .alert)
                weak var usernameTextField: UITextField!
                alertController.addTextField(configurationHandler: { textField in
                    textField.placeholder = "User ID"
                    usernameTextField = textField
                })
                weak var passwordTextField: UITextField!
                alertController.addTextField(configurationHandler: { textField in
                    textField.placeholder = "password"
                    textField.isSecureTextEntry = true
                    passwordTextField = textField
                })
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alertController.addAction(UIAlertAction(title: "Log in", style: .destructive, handler: { action in
                    print(usernameTextField.text! + "\n" + passwordTextField.text!)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    // n번째 섹션의 m번째 row를 그리는데 필요한 cell을 반환하는 메소드입니다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as! TableViewCell 구문을 통해 커스텀 테이블 셀의 값을 가져와서  데이터를 넣어줄 수 있다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let titleLabel = cell.titleLabel
        let dateLabel = cell.dateLabel
        let tagsLabel = cell.tagsLabel
        
        titleLabel?.text = notComplete_filtered[indexPath.row].title
        dateLabel?.text = notComplete_filtered[indexPath.row].deadline
        tagsLabel?.text = notComplete_filtered[indexPath.row].tag
        
        setFontSize(ad: ad, titleLabel, dateLabel, tagsLabel)
        
        if notComplete_filtered[indexPath.row].isComplete {
         cell.accessoryType = .checkmark
        } else{
         cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath) != nil{
            clickedTitle = notComplete_filtered[indexPath.row].title!
        }
    }
    // n번째 섹션에 몇개의 row가 있는지 반환하는 함수입니다
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notComplete_filtered.count
    }
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
