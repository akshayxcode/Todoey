//
//  ViewController.swift
//  Todoey
//
//  Created by Akshay M on 09/10/19.
//  Copyright © 2019 Akshay M. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var listArray = [Item]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Akshay"
        listArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "California"
        listArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Rucksomeburg"
        listArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            listArray = items
        }
    }
    
    //MARK - tableview Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListItem", for: indexPath)
        
        let item = listArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        //Ternary operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        
        
        return cell
    }
    //MARK - tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        listArray[indexPath.row].done = !listArray[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
    }
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
         self.listArray.append(newItem)
            
         self.defaults.setValue(self.listArray, forKey: "TodoListArray")
            
         self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}

