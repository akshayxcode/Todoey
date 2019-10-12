//
//  ViewController.swift
//  Todoey
//
//  Created by Akshay M on 09/10/19.
//  Copyright © 2019 Akshay M. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var listArray = ["Akshay","Rucksomeberg","California"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        listArray = defaults.array(forKey: "TodoListArray") as! [String]
    }
    
    //MARK - tableview Datasource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListItem", for: indexPath)
        cell.textLabel?.text = listArray[indexPath.row]
        return cell
    }
    //MARK - tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(listArray[indexPath.row])
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
         self.listArray.append(textField.text!)
            
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

