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
        // TODO ::
        // 저장된 사항을 확정할 것인지 별도의 화면 띄우기
        // 어떻게 구현할 것인지 방법 찾아봐야함.
        self.presentingViewController?.dismiss(animated: true)
    }
}
