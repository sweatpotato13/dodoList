//
//  Todo.swift
//  dodolist
//
//  Created by JCR on 2020/04/18.
//  Copyright © 2020 dodo. All rights reserved.
//

import Foundation
struct Todo {
    var title: String? = ""
    var deadline : String?
    var description: String?
    var isComplete: Bool = false
    var priority: String = "Mid"
    var tag: String = "None"
 
    init(title: String, deadline: String?, description: String?, isComplete: Bool = false, priority: String, tag: String) {
        self.title = title
        self.deadline = deadline
        self.description = description
        self.isComplete = isComplete
        self.priority = priority
        self.tag = tag
    }
}
