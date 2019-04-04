//
//  ListDetailViewController.swift
//  TodoListIos
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {

    public var delegate : listDelegate?
    var listToEdit : Checklist?
    
    @IBOutlet weak var textField: UITextField! 
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func done(_ sender: Any) {
        if(listToEdit == nil){
            let newList = Checklist(text: textField.text!)
            delegate?.ListDetailViewController(self, didFinishAddingList: newList)
        }
        else if(listToEdit != nil){
            listToEdit?.name = textField.text!
            delegate?.ListDetailViewController(self, didFinishUpdateList: listToEdit!)
        }
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.ListDetailViewControllerDidCancel(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
        doneButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        if(listToEdit != nil){
            textField.text = listToEdit?.name
            self.title = "Edit List"
        }
        
    }
}

extension ListDetailViewController: UITextFieldDelegate{
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

protocol listDelegate : class {
    func ListDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishAddingList item: Checklist)
    func ListDetailViewController(_ controller: ListDetailViewController, didFinishUpdateList item: Checklist)
}
