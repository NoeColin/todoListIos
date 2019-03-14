//
//  AddItemTableViewController.swift
//  TodoListIos
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {
    
    var delegate : ItemDetailDelegate?
    var itemToEdit : ChecklistItem?
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    @IBAction func done(_ sender: Any) {
        if(itemToEdit == nil){
            let newItem = ChecklistItem(text: textField.text!)
            delegate?.ItemDetailViewController(self, didFinishAddingItem: newItem)
        }
        else if(itemToEdit != nil){
            itemToEdit?.text = textField.text!
            delegate?.ItemDetailViewController(self, didFinishUpdateItem: itemToEdit!)
        }
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.ItemDetailViewControllerDidCancel(self)
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

extension ItemDetailViewController: UITextFieldDelegate{
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

protocol ItemDetailDelegate : class {
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishUpdateItem item: ChecklistItem)
}
