//
//  EntryViewController.swift
//  MyToDoList
//
//  Created by binyu on 2021/7/27.
//

import UIKit
import RealmSwift
class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.becomeFirstResponder()
        textField.delegate = self
        
        datePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action:   #selector(didTapSaveButton))
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didTapSaveButton() {
        if let text = textField.text, !text.isEmpty {
            let date = datePicker.date
            realm.beginWrite()
            
            let newItem = ToDoListItem()
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            
            try! realm.commitWrite()
            
            completionHandler?()
            
            navigationController?.popViewController(animated: true)
        }else {
            print("add something")
            navigationController?.popViewController(animated: true )
        }
    }
  

}
