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
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func done(_ sender: Any) {
        print(textField.text)
        let newItem = ChecklistItem(text: textField.text!)
        delegate?.addItemViewController(self, didFinishAddingItem: newItem)
        
    }
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        doneButton.isEnabled = false
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
}
