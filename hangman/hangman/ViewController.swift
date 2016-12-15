//
//  ViewController.swift
//  hangman
//
//  Created by Jay Steingold on 12/13/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var wordCount = 0
    var usedLetters = [String]() //Used string, but each one is only one char
    var correctAnswer = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        //Loads words from start.text into the allWords array
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                //Separator to divide words
                allWords = startWords.components(separatedBy: "\n")
            }
            else {
                allWords = loadDefaultWords()
            }
        } else{
            allWords = loadDefaultWords()
        }
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        
        print(allWords)
        
        startGame(num: wordCount)
    }

    func loadDefaultWords() -> [String] {
        let words = ["jazzy", "cache", "pastiche", "insipid", "bream"]
        return words
    }
    
    func startGame(num: Int) {
        
        //Set title to the number of blank spaces for letters
        //title = String(repeating: "_", count: allWords[wordCount].characters.count)
        title = allWords[wordCount]
        
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        
        //CHANGE TO BLANK SPACES
        title = allWords[0]
        correctAnswer = allWords[0]
        
        usedLetters.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedLetters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = "\(usedLetters[indexPath.row])"
        return cell
    }
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        //Adds editable text input field to UIAlertController
        ac.addTextField()
        
        //If expecting a closure, you can pass final parameter in braces instaed
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] _ in
            //"Unowned" means you do not want strong references for those variables
            //Meaning the variables may be destroyed
            //Alert controller and our current viewcontroller are to be captured as unowned references inside the closure
            //Everything before "in" describes the closure
            //Everything after "in" is the closure
            
            let answer = ac.textFields![0] //Pulls answer from text field
            self.submit(answer: answer.text!)
        }
        
        //Adds an action to the UIAlertController
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    //Change to handle errors
    func submit(answer: String) {
        //let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        //If it's only one character
        if answer.characters.count == 1 {
            //If that character has been guessed before
            if(usedLetters.contains(answer)){
                errorTitle = "Already guessed"
                errorMessage = "Can't you see the word at the top?"
            }
            else{
                //If it hasn't been guessed before, but isn't in the word
                if(correctAnswer.contains(answer)){
                    //
                    usedLetters.insert(answer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    //Insert a row into the table view instead of using reloadData()
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }
                else{
                    
                }
                return
            }
        } else {
           errorTitle = "Not one character"
            errorMessage = "Only one character at a time please"
        }
        
        //Error message for incorrect input
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

