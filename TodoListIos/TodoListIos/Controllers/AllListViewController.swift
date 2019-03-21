//
//  AllListViewController.swift
//  TodoListIos
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
     var ListItem = Array<ChecklistItem>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = ChecklistItem.init(text: "Liste1")
        let item2 = ChecklistItem.init(text: "Liste2")
        let item3 = ChecklistItem.init(text: "Liste3")
        self.ListItem.append(item1)
        self.ListItem.append(item2)
        self.ListItem.append(item3)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
       /// cell.itemLabel.text = item.text
        cell.textLabel?.text = item.text
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.ListItem.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItem", for: indexPath)
        configureText(for: cell,  withItem: ListItem[indexPath.item])
        return cell
    }

    
   

}
