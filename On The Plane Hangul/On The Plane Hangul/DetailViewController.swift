//
//  DetailViewController.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 10/8/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import GameplayKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var num: Int = 0 
    
    var correctAnswer: Int = 0
    var numAnswered: Int = 0
    var numCorrect: Int = 0
    var numWrong: Int = 0
    var message = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("MADE IT TO THE DETAIL")
        print(num)
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        var selectedDeck = decks[num]!.cards
        //Shuffle cards in the deck
        //Shuffle Q and A's (Maybe move to detailView)
        let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: selectedDeck) as! [Card]
        
        //Choose a random answer
        correctAnswer = Int(arc4random_uniform(3))
        print("CORRECT ANSWER IN askQuestion: ")
        print(correctAnswer)
        
        
        button1.setTitle(shuffledDeck[0].answer, for: UIControlState.normal)
        button2.setTitle(shuffledDeck[1].answer, for: UIControlState.normal)
        button3.setTitle(shuffledDeck[2].answer, for: UIControlState.normal)
        
        
        title = shuffledDeck[correctAnswer].question
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        //FOR DEBUGGING
        print("SENDER TAG")
        print(sender.tag)
        print("CORRECT ANSWER: ")
        print(correctAnswer)
        
        if sender.tag == correctAnswer {
            print("YOU GOT ONE CORRECT")
            title = "Correct"
            numCorrect += 1
            print("NUMBER OF CORRECT ANSWERS:")
            print(numCorrect)
        } else {
            title = "Wrong"
            numWrong += 1
        }
        
        numAnswered += 1
        //If have have answered enough questions (CHANGED FOR DEBUG)
        if numAnswered == 1 {
            //If you did well enough, you can move to the next level
            if Double(numCorrect / numAnswered) >= 0.9 {
                decks[num]?.completed = true
                message = "You did it! You can move on to the next section if you like."
            }
            else{
                //Message about trying harder
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. I think you could use more practice."
            }
            
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: askQuestion))
            present(ac, animated: true)
            
        }
        askQuestion()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
