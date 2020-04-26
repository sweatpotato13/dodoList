//
//  TableViewCell.swift
//  dodolist
//  Custom table view cell을 위한 클래스
//
//  Created by handongkim on 2020/04/25.
//  Copyright © 2020 dodo. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var finishedTitleLabel: UILabel!
    @IBOutlet weak var finishedDateLabel: UILabel!
    @IBOutlet weak var finishedTagsLabel: UILabel!
}
