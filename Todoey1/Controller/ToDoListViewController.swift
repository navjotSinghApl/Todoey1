//
//  ViewController.swift
//  Todoey1
//
//  Created by Apple on 14/03/19.
//  Copyright © 2019 Lokesh. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "jose"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "camero"
        itemArray.append(newItem3)
        
        
        
                if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
                    itemArray = items
                }
    }
    
    //Mark - tableview Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // Ternary Operator
        // value = condition ? value if True : value if false
        
        cell.accessoryType = item.done == true ? .checkmark : .none
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    //Mark - tableview Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
                if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
                    tableView.cellForRow(at: indexPath)?.accessoryType = .none
                } else {
                    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add New Item
    
    @IBAction func addNewItem(_ sender: UIButton) {
        
        var textField  =  UITextField()
        let alert = UIAlertController(title: "Add new Item ", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title:"Add  Data " ,style: .default) { (action ) in
            
            let  newItem  = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextfiled) in
            alertTextfiled.placeholder = "Add new Item here.."
            textField = alertTextfiled
            //  textField1 = alertTextfiled
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}

