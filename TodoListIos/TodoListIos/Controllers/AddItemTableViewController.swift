//
//  AddItemTableViewController.swift
//  TodoListIos
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    var delegate : AddItemViewControllerDelegate?
    var itemToEdit : ChecklistItem?
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    @IBAction func done(_ sender: Any) {
        if(itemToEdit == nil){
            let newItem = ChecklistItem(text: textField.text!)
            delegate?.addItemViewController(self, didFinishAddingItem: newItem)
        }
        else if(itemToEdit != nil){
            itemToEdit?.text = textField.text!
            delegate?.addItemViewController(self, didFinishUpdateItem: itemToEdit!)
        }
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        doneButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        if(itemToEdit != nil){
            textField.text = itemToEdit?.text
            self.title = "Edit Item"
        }
        
    }
}

extension AddItemTableViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
         if let oldString = textField.text {
         let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!,with: string)
            // ...
            
            if(newString.isEmpty){
                doneButton.isEnabled = false
            }
            else{
                doneButton.isEnabled = true
            }
        }
        // ..
         return true
    }
   
}

protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(_ controller: AddItemTableViewController, didFinishUpdateItem item: ChecklistItem)
}
