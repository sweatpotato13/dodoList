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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var fontSizeSetted = UIFont.systemFont(ofSize: 17)
//        var fontSizeText = NSMutableAttributedString(string: fontSizeLabel.text!)
//
//
//        // segmented control 액션 달아주기
        fontSize.addTarget(self, action: #selector(segconChanged(segcon:)), for: UIControl.Event.valueChanged)
//
        // 다른 view 관련 함수에 추가 하면 제대로 기능을 할 것 같다.
        // viewDidLoad는 최초 View가 로드 될 때만 수행되니까! -> 찾아보기
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
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    // 변경된 저장 사항을 저장하고 다시 원래 화면으로 돌아감.
    @IBAction func done(_ sender: Any) {
        // alert 창, 각 버튼 설정
        let alert = UIAlertController(title: "확인", message: "설정을 저장하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
        // TODO :: 저장 내용을 변경해서 반영하는 코드 추가
        self.presentingViewController?.dismiss(animated: true)
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
        
        // 버튼을 누르면 크기가 바뀌는 것을 확인
        // 버튼을 눌렀을 때 굳이 글자 크기가 바로 바로 변경될 필요는 없다.
        // 일단 설정값이 잘 반영되는지 확인하기 위한 용도로 사용.
//        var fontSizeSetted = UIFont.systemFont(ofSize: 17)
//        var fontSizeText = NSMutableAttributedString(string: fontSizeLabel.text!)
//
//
//        // segmented control 액션 달아주기
//        fontSize.addTarget(self, action: #selector(segconChanged(segcon:)), for: UIControl.Event.valueChanged)
//
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
    }
    
}
