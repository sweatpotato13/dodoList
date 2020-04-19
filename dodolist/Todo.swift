//
//  Todo.swift
//  dodolist
//
//  Created by JCR on 2020/04/18.
//  Copyright © 2020 dodo. All rights reserved.
//

import Foundation
struct Todo {
    var title: String = ""
    var deadline : String?
    var description: String?
    var isComplete: Bool = false
 
    init(title: String, deadline: String?, description: String?, isComplete: Bool = false) {
        self.title = title
        self.deadline = deadline
        self.description = description
        self.isComplete = isComplete
    }
}
