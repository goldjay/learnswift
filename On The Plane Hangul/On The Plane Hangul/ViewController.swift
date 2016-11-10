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
    
    var decks = [[String]()]
    var deck1 = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        deck1 += ["ah", "eo", "eu", "i", "o"]
        decks.insert(deck1, at: 0) //CHANGE TO VARIABLE AND MADE LOOP?
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
            print("INDEX PATH")
            print(indexPath.row)
            vc.selectedDeck = decks[indexPath.row]
            
            
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

