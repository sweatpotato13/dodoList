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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // segmented control 액션 달아주기
        fontSize.addTarget(self, action: #selector(segconChanged(segcon:)), for: UIControl.Event.valueChanged)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // 변경된 저장 사항을 저장하고 다시 원래 화면으로 돌아감.
    @IBAction func done(_ sender: Any) {
        
        // AppDelegate에 설정값 저장
        ad?.alarm = alarm.isOn
        ad?.darkMode = darkMode.isOn
        ad?.lock = lock.isOn

        // alert 창, 각 버튼 설정
        let alert = UIAlertController(title: "확인", message: "설정을 저장하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
        // TODO :: 저장 내용을 변경해서 반영하는 코드 추가
        self.presentingViewController?.dismiss(animated: true)

        }

        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
    
    // 글꼴 크기 선택 옵션 발생
    @objc func segconChanged(segcon: UISegmentedControl) {
        var text: String!
        
        switch segcon.selectedSegmentIndex {
            case 0:
                text = "Large"
            case 1:
                text = "Medium"
            case 2:
                text = "Small"
            default:
                return
        }
        // AppDelegate애 설정값 저장
        ad?.fontSize = text
    }
    
}
