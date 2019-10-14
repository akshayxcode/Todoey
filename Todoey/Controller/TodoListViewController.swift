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
    
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItem()
        

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
        saveItems()
    }
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
         self.listArray.append(newItem)
            
          self.saveItems()
         
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.listArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error while encoding \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItem() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                listArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error while decoding \(error)")
            }
        }
    }

}

