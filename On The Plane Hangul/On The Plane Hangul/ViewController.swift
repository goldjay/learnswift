//
//  ViewController.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 10/8/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var levels = 10
    var currentDeck: [[String]] = [[]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let savedDecks = defaults.object(forKey: "decks") as? Data {
            decks = NSKeyedUnarchiver.unarchiveObject(with: savedDecks) as! [Deck]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return levels
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath)
        cell.textLabel?.text = "Level " + String(indexPath.row + 1)
        cell.tag = indexPath.row + 1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Clear the currentDeck
        currentDeck = []
        
        //Check if there is not a deck in decks, otherwise create a new one
        if(decks[indexPath.row + 1] == nil){
            print("THIS IS THE INDEX PATH ROW:")
            print(indexPath.row + 1)
            
            //Find and load level string from the disk
            if let levelFilePath = Bundle.main.path(forResource: "level\(indexPath.row + 1)", ofType: "txt") {
                
                if let levelContents = try? String(contentsOfFile: levelFilePath) {
                    print(levelContents)
                    //Split Q and A's by linebreak
                    let lines = levelContents.components(separatedBy: CharacterSet.newlines)
                        .filter{ !$0.isEmpty }
                    
                    print(lines)
                    
                    //Enumerated gives us the position of each item in the lines array
                    for line in lines{
                        //Splits each line into answer and clue
                        let parts = line.components(separatedBy: ":")
                        
                        print(parts[0])
                        print(parts[1])
                        
                        let card = [parts[0],parts[1]]
                        currentDeck.append(card)
                    }
                    //Maybe save this only when the deck has been completed
                    let deck = Deck(cards: currentDeck)
                    decks[indexPath.row] = deck
                    
                }
            }
            else{
                //Present view controller about not having a deck
                errorAlert(message: "No file for the deck! Error")
            }
        }
        
        //Names the view controller we want to navigate to
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            
            /* FOR THE FUTURE
            * Check database if there is a deck already made
            * If so, use that deck, otherwise, create a new one
            *
            */
            
            
            
            //If it's not the first deck
            //Check if the one before it exists and if it has been completed
            if(indexPath.row != 0 && decks[indexPath.row - 1] != nil && decks[indexPath.row - 1]?.completed == false){
                errorAlert(message: "You're going to have to finish the levels before this one")
            }
            
            vc.num = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func errorAlert(message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(ac, animated: true)
        
    }
    
    
}

