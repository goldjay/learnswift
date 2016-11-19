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
    var currentDeck = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            
            /* FOR THE FUTURE
            * Check database if there is a deck already made
            * If so, use that deck, otherwise, create a new one
            *
            */
            
            //Find and load level string from the disk
            if let levelFilePath = Bundle.main.path(forResource: "level\(indexPath.row + 1)", ofType: "txt") {

                if let levelContents = try? String(contentsOfFile: levelFilePath) {
                    //Split Q and A's by linebreak
                    var lines = levelContents.components(separatedBy: "\n")
                    
                    //Enumerated gives us the position of each item in the lines array
                    for (index, line) in lines.enumerated() {
                        //Splits each line into answer and clue
                        let parts = line.components(separatedBy: ": ")
                        let card = Card(question: parts[0], answer: parts[1])
                        currentDeck.append(card)
                    }
                }
            }
            
            
            vc.selectedDeck = currentDeck
            
            
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    


}

