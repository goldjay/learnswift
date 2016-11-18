//
//  ViewController.swift
//  project8
//
//  Created by Jay Steingold on 11/16/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    //Updates the score label whenever the score variable is changed!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Loops through all views inside viewController
        //Modify only if the tag is 1001
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        }
        loadLevel()
    }
    
    @IBAction func submitTapped(_ sender: AnyObject) {
        if let solutionPosition = solutions.index(of: currentAnswer.text!) {
            activatedButtons.removeAll()
            
            var splitClues = answersLabel.text!.components(separatedBy: "\n")
            splitClues[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitClues.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    //Resets answer and displays all answer input buttons
    @IBAction func clearTapped(_ sender: AnyObject) {
        currentAnswer.text = ""
        
        for btn in activatedButtons {
            btn.isHidden = false
        }
        activatedButtons.removeAll()
    }
    
    func letterTapped(btn: UIButton) {
        //Gets title from tapped button
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        //Adds tapped button to activated
        activatedButtons.append(btn)
        //Hides the button
        btn.isHidden = true
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        //Find and load level string from the disk
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                var lines = levelContents.components(separatedBy: "\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                
                //Enumerated gives us the position of each item in the lines array
                for (index, line) in lines.enumerated() {
                    //Splits each line into answer and clue
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    //Need to do +1 because the index actually starts at 0
                    clueString += "\(index + 1). \(clue)\n"
                    
                    //Remove all "|" characters fromt the string
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.characters.count)letters\n"
                    solutions.append(solutionWord)
                    
                    //Turns answer into question by breaking into parts and placing in an array
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        //Removes white spaces and new lines from front and back of string
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        
        if letterBits.count == letterButtons.count {
            // 0 up to but not including the number of letterBits
            for i in 0 ..< letterBits.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            
        }
    }
    }
    
    func levelUp(action: UIAlertAction!) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

