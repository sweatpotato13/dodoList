//
//  SettingViewController.swift
//  dodolist
//
//  Created by handongkim on 2020/04/07.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class SettingViewController : UIViewController {
    
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

        }

        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
}
