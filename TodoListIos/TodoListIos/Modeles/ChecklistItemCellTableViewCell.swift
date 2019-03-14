//
//  ChecklistItemCellTableViewCell.swift
//  TodoListIos
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistItemCellTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var check: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
