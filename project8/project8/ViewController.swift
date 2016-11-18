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
    
    var score = 0
    var level = 1
    
    @IBAction func submitTapped(_ sender: AnyObject) {
    }
    @IBAction func clearTapped(_ sender: AnyObject) {
    }
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
    
    func letterTapped(btn: UIButton) {
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

