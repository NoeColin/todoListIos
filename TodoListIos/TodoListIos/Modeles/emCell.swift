//
//  emCell.swift
//  TodoListIos
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class emCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    
}
