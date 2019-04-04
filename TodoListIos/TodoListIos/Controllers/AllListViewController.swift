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
       // loadCheckLists()
    }
    

    
    var lists = Array<Checklist>()
    
    var documentDirectory: URL {
        get{
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    
    var dataFileUrl: URL{
        get{
            return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
        }
    }

    
    func saveCheckLists(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(lists)
        try! data.write(to: dataFileUrl)
        print(String(data:data, encoding: .utf8)!)
    }
    
    func loadCheckLists(){
        let decoder = JSONDecoder()
        let jsonFile = try! Data(contentsOf: dataFileUrl)
        let data = try! decoder.decode(Array<Checklist>.self, from: jsonFile)
        print(data)
        lists = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = Checklist.init(text: "Liste12")
        let item2 = Checklist.init(text: "Liste23")
        let item3 = Checklist.init(text: "Liste34")
        self.lists.append(item1)
        self.lists.append(item2)
        self.lists.append(item3)
        
        var i = 0
        var y = 0
        for check in lists{
            i += 1
            y += 5
            check.name = "liste \(i)"
            let item1 = ChecklistItem.init(text:"item \(y)", checked: false)
            let item2 = ChecklistItem.init(text:"item \(y+12)", checked: false)
            let item3 = ChecklistItem.init(text:"item \(y+24)", checked: false)
            check.items.append(item1)
            check.items.append(item2)
            check.items.append(item3)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureText(for cell: ChecklistItemCellTableViewCell, withItem item: Checklist){
       /// cell.itemLabel.text = item.text
        cell.label?.text = item.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItem", for: indexPath)
        configureText(for: cell as! ChecklistItemCellTableViewCell,  withItem: lists[indexPath.item])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "addList"){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ListDetailViewController
            delegateVC.delegate = self
        }
        else if("editList" == segue.identifier){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ListDetailViewController
            delegateVC.delegate = self
            let cell = sender as! ChecklistItemCellTableViewCell
            let index = tableView.indexPath(for: cell)
            delegateVC.listToEdit = lists[index!.row]
        }
        else if("CheckListAccess" == segue.identifier){
            let delegateVC = segue.destination as! ChecklistViewController
            let cell = sender
            let index =  tableView.indexPath(for: cell as! UITableViewCell)
            delegateVC.ChecklistItems = lists[index!.row].items
            delegateVC.list = lists[index!.row]
        }
    }

    
   

}

extension AllListViewController : listDelegate{
    func ListDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true)
    }
    
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishAddingList item: Checklist) {
        dismiss(animated: true)
        lists.append(item)
        tableView.insertRows(at: [IndexPath(row: lists.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
          saveCheckLists()
    }
    
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishUpdateList item: Checklist) {
        dismiss(animated: true)
        let index : Int = lists.index(where: {$0 === item})!
        lists[index].name = item.name
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
         saveCheckLists()
    }
}


