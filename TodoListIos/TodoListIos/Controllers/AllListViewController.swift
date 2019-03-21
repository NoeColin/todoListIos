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
    
    var lists = Array<Checklist>()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = Checklist.init(text: "Liste12")
        let item2 = Checklist.init(text: "Liste23")
        let item3 = Checklist.init(text: "Liste34")
        self.lists.append(item1)
        self.lists.append(item2)
        self.lists.append(item3)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureText(for cell: UITableViewCell, withItem item: Checklist){
       /// cell.itemLabel.text = item.text
        cell.textLabel?.text = item.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItem", for: indexPath)
        configureText(for: cell,  withItem: lists[indexPath.item])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "addIList"){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ListDetailViewController
            delegateVC.delegate = self
        }
        else if("editItem" == segue.identifier){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ListDetailViewController
            delegateVC.delegate = self
            let cell = sender as! emCell
            let index = tableView.indexPath(for: cell)
            delegateVC.itemToEdit = lists[index!.row]
        }
        else if("CheckListAccess" == segue.identifier){
            let delegateVC = segue.destination as! ChecklistViewController
            let cell = sender
            let index =  tableView.indexPath(for: cell as! UITableViewCell)
            delegateVC.list = lists[index!.row]
        }
    }

    
   

}


