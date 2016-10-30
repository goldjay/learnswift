//
//  ViewController.swift
//  project5
//
//  Created by Jay Steingold on 10/17/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    var wordCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UIAlertController with space for the user to make an answer
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
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
        
        startGame(num: wordCount)
    }
    
    func loadDefaultWords() -> [String] {
        let words = ["sesquipedalian", "verisimilitude", "masticate", "insipid", "quotidian"]
        return words
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
    
    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    //Insert a row into the table view instead of using reloadData()
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    return
                }
                else {
                    if(lowerAnswer.characters.count < 3) {
                            errorTitle = "Word is too short"
                        errorMessage = "We don't want any tiny words. Throw it back!"
                    }
                    else {
                    errorTitle = "Word not recognized"
                    errorMessage = "You can't just make them up, you know!"
                    }
                }
            }
            else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        }
        else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title!.lowercased())'!"
        }
        
        showErrorMessage(title: errorTitle, message: errorMessage)
        
    }
    
    func showErrorMessage(title: String, message: String) {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = title!.lowercased()
        
        for letter in word.characters {
            //If the letter is found in the word, remove it
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        if (word == title) {
            return false
        }
        
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        if(word.characters.count < 3) {
            return false
        }
        
        //iOS class designed to spot spelling errors
        let checker = UITextChecker()
        //Use utf16 when working with UIKit, SpriteKit or any apple framework
        let range = NSMakeRange(0, word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        //If not mistakes are found, it returns NSNotFound, otherwise returns the misspelling location
        return misspelledRange.location == NSNotFound
    }
    
    func startGame(num: Int) {
        
        title = allWords[wordCount]
        //Clears the words we used in the previous game, if any
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        wordCount += 1
    }
    
    //Counts the number of used words
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

