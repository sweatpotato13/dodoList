//
//  ViewController.swift
//  dodolist
//
//  Created by JCR on 2020/04/05.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit
var list = [Todo]()
class ViewController: UIViewController {
    
    @IBOutlet weak var doo: UIPageControl!
    var array = ["HELLO", "Hello World" , "World Hello"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doo.numberOfPages = 3
        doo.currentPage = 0
        doo.pageIndicatorTintColor = UIColor.gray
        doo.currentPageIndicatorTintColor = UIColor.red
    }

    
    @IBAction func pageControl(_ sender: Any) {
        foo.text = array[doo.currentPage]
    }	
    
    @IBOutlet weak var foo: UILabel!
    @IBAction func boo(_ sender: Any) {
        if(foo.text == "Hello world"){  
            foo.text = "boo!"
            
        }
        else{
            foo.text = "Hello world"
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
    }
    
    // Todolist 확인을 위한 임시 버튼
    @IBAction func goTodos(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let uvc = storyboard.instantiateViewController(withIdentifier: "TodoVC")
        
        self.present(uvc, animated: true)
    }
}

