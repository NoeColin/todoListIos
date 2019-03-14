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
    
    override func awakeFromNib() {
       loadCheckListItems()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = ChecklistItem.init(text: "Cellule1")
        let item2 = ChecklistItem.init(text: "Cellule2")
        let item3 = ChecklistItem.init(text: "Cellule3")
        self.ChecklistItems.append(item1)
        self.ChecklistItems.append(item2)
        self.ChecklistItems.append(item3)
        print(documentDirectory)
        print(dataFileUrl)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func saveCheckListItems(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        var data = try! encoder.encode(ChecklistItems)
        try! data.write(to: dataFileUrl)
        print(String(data:data, encoding: .utf8)!)
    }
    
    func loadCheckListItems(){
        let decoder = JSONDecoder()
        let jsonFile = try! Data(contentsOf: dataFileUrl)
        var data = try! decoder.decode(Array<ChecklistItem>.self, from: jsonFile)
        print(data)
        ChecklistItems = data
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
        configureText(for: cell as! emCell, withItem: ChecklistItems[indexPath.item])
        configureCheckmark(for: cell as! emCell, withItem: ChecklistItems[indexPath.item])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){  tableView.deselectRow(at: indexPath, animated: true)
        ChecklistItems[indexPath.item].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func configureCheckmark(for cell: emCell, withItem item: ChecklistItem){
        if(item.checked){
            cell.checkLabel.isHidden = false
        }else {
            cell.checkLabel.isHidden = true
        }
        saveCheckListItems()
        //cell.accessoryType = item.checked ? .checkmark : .none
        
    }
    
    func configureText(for cell: emCell, withItem item: ChecklistItem){
        cell.itemLabel.text = item.text
        //cell.textLabel?.text = item.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "addItem"){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ItemDetailViewController
            delegateVC.delegate = self
        }
        else if("editItem" == segue.identifier){
            let navigation = segue.destination as! UINavigationController
            let delegateVC = navigation.topViewController as! ItemDetailViewController
            delegateVC.delegate = self
            let cell = sender as! emCell
            let index = tableView.indexPath(for: cell)
            delegateVC.itemToEdit = ChecklistItems[index!.row]
        }
    }
}

extension ChecklistViewController : ItemDetailDelegate{
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishUpdateItem item: ChecklistItem) {
        dismiss(animated: true)
        let index : Int = ChecklistItems.index(where: {$0 === item})!
        ChecklistItems[index].text = item.text
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        saveCheckListItems()
    }
    
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController){
        dismiss(animated: true)
    }
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem){
        dismiss(animated: true)
        ChecklistItems.append(item)
        tableView.insertRows(at: [IndexPath(row: ChecklistItems.count - 1, section: 0)], with: UITableView.RowAnimation.automatic)
        saveCheckListItems()
    }
}

