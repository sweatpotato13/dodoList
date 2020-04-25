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
    
    // TODO :: 초기값을 설정된 값으로 전환하기
    override func viewDidLoad() {
        super.viewDidLoad()
        // segmented control 액션 달아주기
        fontSize.addTarget(self, action: #selector(segconChanged(segcon:)), for: UIControl.Event.valueChanged)
    }
    
    @IBAction func done(_ sender: Any) {
        // alert 창, 각 버튼 설정
        let alert = UIAlertController(title: "확인", message: "설정을 저장하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
        // TODO :: 저장 내용을 변경해서 반영하는 코드 추가
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
    // ISSUE :: 초기값이 설정이 안된다. 한 번 바꿔준 후 설정해야 한다.
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
