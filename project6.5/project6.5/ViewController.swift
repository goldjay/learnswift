//
//  ViewController.swift
//  project6.5
//
//  Created by Jay Steingold on 10/30/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(addItem))

    }
    
    func addItem() {
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] _ in
            let task = ac.textFields![0]
            self.submit(task: task.text!)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(task: String) {
        //If the string isn't empty
        if(task.characters.count != 0) {
            shoppingList.append(task)
            //First position in the table
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

