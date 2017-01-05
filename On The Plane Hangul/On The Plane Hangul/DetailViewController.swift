//
//  DetailViewController.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 10/8/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import GameplayKit

//Can declare in a separate file
protocol sendBack {
    func setFinishedDeck(viewedDeck: Deck, num: Int)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var selectedDeck: Deck?
    var num: Int?
    
    var sendBack: sendBack?
    
    
    var correctAnswer: Int = 0
    var numAnswered: Int = 0
    var numCorrect: Int = 0
    var message = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MADE IT TO THE DETAIL")
        print(selectedDeck)
        
        //Check if the user has seen the deck. If not, show tutorial
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        //Shuffle cards in the deck
        //Shuffle Q and A's (Maybe move to detailView)
        let cards = selectedDeck?.cards
        
        
        //Possibly change to not shuffle every time
        let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards!) as! [[String]]
        
        //Choose a random answer
        correctAnswer = Int(arc4random_uniform(3))
        print("CORRECT ANSWER IN askQuestion: ")
        print(correctAnswer)
        
        
        button1.setTitle(shuffledDeck[0][1], for: UIControlState.normal)
        button2.setTitle(shuffledDeck[1][1], for: UIControlState.normal)
        button3.setTitle(shuffledDeck[2][1], for: UIControlState.normal)
        
        
        title = shuffledDeck[correctAnswer][0]
    }

 
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        //FOR DEBUGGING
        print("SENDER TAG")
        print(sender.tag)
        print("CORRECT ANSWER: ")
        print(correctAnswer)
        
        if sender.tag == correctAnswer {
            print("YOU GOT ONE CORRECT")
            numCorrect += 1
            print("NUMBER OF CORRECT ANSWERS:")
            print(numCorrect)
        }
        
        numAnswered += 1
        //If have have answered enough questions (CHANGED FOR DEBUG)
        if numAnswered == 1 {
            //If you did well enough, you can move to the next level
            if Double(numCorrect / numAnswered) >= 0.9 {
                //decks[num]?.completed = true
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. You can move on to the next section if you like."
                selectedDeck?.completed = true
            }
            else{
                //Message about trying harder
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. I think you could use more practice."
            }
            
            
            let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            //Add option to continue or to go back to root
            
            present(ac, animated: true)
            numAnswered = 0
            correctAnswer = 0
            
            //Send info back
            sendBack?.setFinishedDeck(viewedDeck: selectedDeck!, num: num!)
    
        }
        //askQuestion()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
