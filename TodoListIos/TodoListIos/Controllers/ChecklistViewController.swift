//
//  ViewController.swift
//  TodoListIos
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var ChecklistItems = Array<ChecklistItem>()

    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = ChecklistItem.init(text: "Cellule1")
        let item2 = ChecklistItem.init(text: "Cellule2")
        let item3 = ChecklistItem.init(text: "Cellule3")
        self.ChecklistItems.append(item1)
        self.ChecklistItems.append(item2)
        self.ChecklistItems.append(item3)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
        let item4 = ChecklistItem.init(text: "Cellule51534")
        self.ChecklistItems.append(item4)
        let indexPath = IndexPath(row: ChecklistItems.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.ChecklistItems.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        ChecklistItems.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureText(for: cell, withItem: ChecklistItems[indexPath.item])
        configureCheckmark(for: cell, withItem: ChecklistItems[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){  tableView.deselectRow(at: indexPath, animated: true)
        ChecklistItems[indexPath.item].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.accessoryType = item.checked ? .checkmark : .none
    }
    
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.textLabel?.text = item.text
    }

}

