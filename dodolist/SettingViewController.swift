//
//  SettingViewController.swift
//  dodolist
//
//  Created by handongkim on 2020/04/07.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class SettingViewController : UIViewController {
    
    // AppDelegate 객체에 값 저장
    let ad = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var fontSize: UISegmentedControl!
    @IBOutlet weak var alarm: UISwitch!
    @IBOutlet weak var darkMode: UISwitch!
    @IBOutlet weak var lock: UISwitch!
    // ===================================================
    
    @IBOutlet weak var fontSizeLabel: UILabel!
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var lockAlarm: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if((ad?.fontSize)! == "Large") {
            fontSize.selectedSegmentIndex = 0
        } else if((ad?.fontSize)! == "Medium") {
            fontSize.selectedSegmentIndex = 1
        } else if((ad?.fontSize)! == "Small") {
            fontSize.selectedSegmentIndex = 2
        }
        alarm.setOn((ad?.alarm!)!, animated: false)
        darkMode.setOn((ad?.darkMode)!, animated: false)
        lock.setOn((ad?.lock)!, animated: false)
        // segmented control 액션 달아주기
        fontSize.addTarget(self, action: #selector(segconChanged(segcon:)), for: UIControl.Event.valueChanged)
    }
    
    @IBAction func done(_ sender: Any) {
        // alert 창, 각 버튼 설정
        let alert = UIAlertController(title: "확인", message: "설정을 저장하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            self.navigationController?.popViewController(animated: true)
            // AppDelegate에 설정값 저장
            self.ad?.alarm = self.alarm.isOn
            self.ad?.darkMode = self.darkMode.isOn
            self.ad?.lock = self.lock.isOn
        }

        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
    
    // 글꼴 크기 선택 옵션 발생
    @objc func segconChanged(segcon: UISegmentedControl) {
        switch segcon.selectedSegmentIndex {
            case 0:
                ad?.fontSize = "Large"
            case 1:
                ad?.fontSize = "Medium"
            case 2:
                ad?.fontSize = "Small"
            default:
                return
        }
    }
    
}
