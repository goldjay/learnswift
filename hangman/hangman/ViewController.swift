//
//  ViewController.swift
//  hangman
//
//  Created by Jay Steingold on 12/13/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var wordCount = 0
    var usedLetters = [Character]()

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
        
        print(allWords)
        
        startGame(num: wordCount)
    }

    func loadDefaultWords() -> [String] {
        let words = ["jazzy", "cache", "pastiche", "insipid", "bream"]
        return words
    }
    
    func startGame(num: Int) {
        title = allWords[wordCount]
        //Clears the words we used in the previous game, if any
        usedLetters.removeAll(keepingCapacity: true)
        //tableView.reloadData()
        wordCount += 1
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

