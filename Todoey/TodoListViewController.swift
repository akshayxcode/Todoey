//
//  ViewController.swift
//  Todoey
//
//  Created by Akshay M on 09/10/19.
//  Copyright © 2019 Akshay M. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let listArray = ["item1","item2","item3"]

    override func viewDidLoad() {
        super.viewDidLoad()
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


}

