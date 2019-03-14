//
//  ViewController.swift
//  Todoey1
//
//  Created by Apple on 14/03/19.
//  Copyright © 2019 Lokesh. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["ToDo", "Buy Clothes", "got destroy dvd player"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }

    //Mark - tableview Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //Mark - tableview Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Mark - Add New Item
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
       var textField = UITextField()
        
       let alert = UIAlertController(title: "Add new Todoey Item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user tapped the button
          
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextfiled) in
            alertTextfiled.placeholder = "Add new Item here.."
            textField = alertTextfiled
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

