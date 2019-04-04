//
//  Checklist.swift
//  TodoListIos
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class Checklist: Codable {
    var name : String
    var items : [ChecklistItem]
    
    init(text:String, itemsList: [ChecklistItem] = []){
        self.name = text
        self.items = itemsList
    }
}
