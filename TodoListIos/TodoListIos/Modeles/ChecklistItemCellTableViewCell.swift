//
//  ChecklistItemCellTableViewCell.swift
//  TodoListIos
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistItemCellTableViewCell: UITableViewCell {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    @IBOutlet weak var label: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
