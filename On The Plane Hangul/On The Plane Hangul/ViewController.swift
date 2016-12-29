//
//  ViewController.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 10/8/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit



class ViewController: UITableViewController, sendBack {
    
    //For the decks
    var levels = 10
    var currentDeck: [[String]] = [[]]
    //Default value for decks
    var decks = [Deck]()
    
    var sentFromDetail: Deck?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DEBUG FOR CLEARING DATA
        decks = [Deck]()
        save()
        
        let defaults = UserDefaults.standard
        
        self.tableView.backgroundColor = UIColor.blue
        self.tableView.backgroundView?.backgroundColor = UIColor.blue
        
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
        cell.backgroundColor = UIColor.clear
        
        cell.textLabel?.text = "Level " + String(indexPath.row + 1)
        cell.tag = indexPath.row + 1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Clear the currentDeck
        currentDeck = []
        print("DECK COUNT: ")
        print(decks.count)
        
        print("INDEX COUNT")
        print(indexPath.row)
        
        
        
        
        //Check if there is not a deck in decks, otherwise create a new one
        if(decks.count >= indexPath.row){
            
            //Find and load level string from the disk
            if let levelFilePath = Bundle.main.path(forResource: "level\(indexPath.row + 1)", ofType: "txt") {
                
                if let levelContents = try? String(contentsOfFile: levelFilePath) {
                    //Split Q and A's by linebreak
                    let lines = levelContents.components(separatedBy: CharacterSet.newlines)
                        .filter{ !$0.isEmpty }
                    
                    for line in lines{
                        //Splits each line into answer and clue
                        let parts = line.components(separatedBy: ":")
                        
                        let card = [parts[0],parts[1]]
                        print(card)
                        currentDeck.append(card)
                    }
                    
                    //Maybe save this only when the deck has been completed
                    let deck = Deck(cards: currentDeck)
                    decks.append(deck)
                    save()
                }
            }
            else{
                //Present view controller about not having a deck
                errorAlert(message: "No file for the deck! Error")
            }
            
            //If we haven't completed the deck, show the tutorial
            if(decks[indexPath.row].completed == false){
                //Check if the deck has been completed
                //If not go to tutorial view
                if let vc = storyboard?.instantiateViewController(withIdentifier: "Tutorial") as? TutorialViewController {
                    
                    //Get some tutorial text based on the deck
                    vc.c = "A"
                    vc.ex = "You know, like Apple?"
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            
            
   /*
            //Present detail View Controller
            //Names the view controller we want to navigate to
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                
                //For sending data back
                vc.sendBack = self
                
                print("HERE ARE THE DECKS:")
                print(decks)
                
                
                /* FOR THE FUTURE
                 * Check database if there is a deck already made
                 * If so, use that deck, otherwise, create a new one
                 *
                 */
                
                //Send deck number for reference to detailView
                
                //Add condition to check if the deck has been completed.
                //If not, go to tutorialView first
                
                //Check if we have already completed
                if(indexPath.row == 0 || decks[indexPath.row - 1].completed == true){
                    vc.selectedDeck = decks[indexPath.row]
                    vc.num = indexPath.row
                    print(vc.selectedDeck)
                    navigationController?.pushViewController(vc, animated: true)
                } else{
                    errorAlert(message: "You should finish the levels before this one!")
                }
            }
      */
        }
        else{
            //Present view controller about not having a deck
            errorAlert(message: "You should finish the levels before this one")
        }
 
    }
    
    func errorAlert(message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(ac, animated: true)
        
    }
    
    //Saves array as an object to userDefaults
    func save() {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: decks)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "decks")
    }
    
    
    //Do something with the data returned
    func setFinishedDeck(viewedDeck: Deck){
        
        self.sentFromDetail = viewedDeck
        print("YOU GOT THIS DECK!")
        print(viewedDeck)
    }
    
}

