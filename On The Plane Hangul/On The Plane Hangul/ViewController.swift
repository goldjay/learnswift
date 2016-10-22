//
//  ViewController.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 10/8/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var levels = Array(1...10)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        print("Items: " + "\(items)")
        
        for item in items {
            if item.hasPrefix("1") {
                print("OMG I FOUND AN ITEM!")
                print(item)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return levels.count
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath)
        cell.textLabel?.text = "Level " + String(levels[indexPath.row])
        cell.tag = levels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Names the view controller we want to navigate to
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            //Sets the variable in the new view to a variable in the old
            vc.deckNum = levels[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

