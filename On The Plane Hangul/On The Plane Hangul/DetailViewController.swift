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
    func setFinishedDeck(viewedDeck: Deck, numFromDetail: Int)
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

    func backToMenu(action: UIAlertAction! = nil) {
        //Send info back
        //sendBack?.setFinishedDeck(viewedDeck: selectedDeck!, numFromDetail: num!)
        navigationController?.popToRootViewController(animated: true)
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
        if numAnswered == 10 {
            
            print(Double(numCorrect/numAnswered))
            
            //If you did well enough, you can move to the next level
            if Double(numCorrect) / Double(numAnswered) >= 0.9 {
                selectedDeck?.completed = true
                
                //Maybe change this to a percentage if add # of cards
                selectedDeck?.highScore = numCorrect
                
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. You can move on to the next section if you like."
                selectedDeck?.completed = true
            }
            else{
                //Message about trying harder
                message = "You have answered \(numCorrect) out of \(numAnswered) questions correct. I think you could use more practice."
            }
            
             //Send info back
            sendBack?.setFinishedDeck(viewedDeck: selectedDeck!, numFromDetail: num!)
            
            //Reset stats
            numAnswered = 0
            numCorrect = 0
            
            let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Back", style: .default, handler: backToMenu))
            ac.addAction(UIAlertAction(title: "Again", style: .default, handler: askQuestion))
        
            present(ac, animated: true)
            
        }
        askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
