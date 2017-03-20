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
    var levels = 9
    var currentDeck: [[String]] = [[]]
    //Default value for decks
    var decks = [Deck]()
    
    var sentFromDetail: Deck?
    var numFromDetail: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*    DEBUG FOR CLEARING DATA    */
        decks = [Deck]()
        save()
        
        print("HERE ARE THE DECKS")
        print(decks)
        
        let defaults = UserDefaults.standard
        
        //self.tableView.backgroundColor = UIColor.gray
        //self.tableView.backgroundView?.backgroundColor = UIColor.blue
        
        if let savedDecks = defaults.object(forKey: "decks") as? Data {
            decks = NSKeyedUnarchiver.unarchiveObject(with: savedDecks) as! [Deck]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return levels
    }
    
    override func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quiz", for: indexPath)
        //cell.backgroundColor = UIColor.clear
        
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
        
        
        
        //Check decks size + 1 == indexPath.row
        
        //Check if the deck at the current size is completed
        
        //Then create the deck
        
        //Check if deck can exist
        
        //Check if deck does exist
        
        
        
        
        
        
        
        //Checks to see if we should create a new deck
        if(decks.count == indexPath.row && (indexPath.row == 0 || decks[indexPath.row - 1].completed == true) ){
            
            //Find and load level string from the disk
            if let levelFilePath = Bundle.main.path(forResource: "level\(indexPath.row + 1)", ofType: "txt") {
                
                if let levelContents = try? String(contentsOfFile: levelFilePath) {
                    //Split Q and A's by linebreak
                    let lines = levelContents.components(separatedBy: CharacterSet.newlines)
                        .filter{ !$0.isEmpty }
                    
                    for line in lines{
                        //Splits each line into answer and clue
                        let parts = line.components(separatedBy: ":")
                        
                        let card = [parts[0],parts[1], parts[2]]
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
                    vc.deck = decks[indexPath.row]
                    vc.num = indexPath.row
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            else{
                //Present detail View Controller
                //Names the view controller we want to navigate to
                if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                    
                    //For sending data back
                    vc.sendBack = self
                    
                    print("HERE ARE THE DECKS:")
                    print(decks)
                    
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
                
            }
            
        }
        else if(decks.count > indexPath.row){
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                
                //For sending data back
                vc.sendBack = self
                
                print("HERE ARE THE DECKS:")
                print(decks)
                
                //Check if we have already completed
                    vc.selectedDeck = decks[indexPath.row]   
                    vc.num = indexPath.row     //Number of the deck used
                    print(vc.selectedDeck)
                    navigationController?.pushViewController(vc, animated: true)
            }
        }
        else{
            errorAlert(message: "You should finish the levels before this one!")
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
    func setFinishedDeck(viewedDeck: Deck, numFromDetail: Int){
        
        self.sentFromDetail = viewedDeck
        self.numFromDetail = numFromDetail
        
        decks[numFromDetail].completed = viewedDeck.completed
        
        //If we have a new high score, update it
        if(viewedDeck.highScore > decks[numFromDetail].highScore){
            decks[numFromDetail].highScore = viewedDeck.highScore
        }
        
        
        //Also set the high score and any other stats
        
        save()
        
        print("YOU GOT THIS DECK!")
        print(viewedDeck)
        print("AND THIS NUM")
        print(numFromDetail)
    }
    
}

