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
    
    var selectedDeck: [Card] = []
    
    var correctAnswer: Int = 0
    var numAnswered: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("MADE IT TO THE DETAIL")
        print(selectedDeck)
        for a in selectedDeck {
            print(a.question)
            print(a.answer)
            
        }
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        //Shuffle cards in the deck
        //Shuffle Q and A's (Maybe move to detailView)
        let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: selectedDeck) as! [Card]
        
        //Choose a random answer
        let correctAnswer = Int(arc4random_uniform(3))
        
        print("CORRECT ANSWER: ")
        print(correctAnswer)
        
        button1.setTitle(shuffledDeck[0].answer, for: UIControlState.normal)
        button2.setTitle(shuffledDeck[1].answer, for: UIControlState.normal)
        button3.setTitle(shuffledDeck[2].answer, for: UIControlState.normal)
        
        
        title = shuffledDeck[correctAnswer].question
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        print("SENDER TAG")
        print(sender.tag)
        
        if sender.tag == correctAnswer {
            title = "Correct"
            //score += 1
        } else {
            title = "Wrong"
            //score -= 1
        }
        
        numAnswered += 1
        //Ask if they want to continue every 10 questions
        if numAnswered % 10 == 0{
            let ac = UIAlertController(title: title, message: "You have answered \(numAnswered) questions.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue?", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        askQuestion()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
