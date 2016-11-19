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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("MADE IT TO THE DETAIL")
        print(selectedDeck)
        for a in selectedDeck {
            print(a.question)
            print(a.answer)
            
        }
        
        askQuestion()
        
        
        //Load and create the decks
        
        //One deck for questions and another for answers
        
        //Create askquestion method

        //title = String(deckNum!)
    }
    
    func askQuestion() {
        //Shuffle cards in the deck
        //Shuffle Q and A's (Maybe move to detailView)
        let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: selectedDeck) as! [Card]
        
        //Choose a random answer
        let correctAnswer = Int(arc4random_uniform(3))
        
        button1.setTitle(shuffledDeck[0].answer, for: UIControlState.normal)
        button2.setTitle(shuffledDeck[1].answer, for: UIControlState.normal)
        button3.setTitle(shuffledDeck[2].answer, for: UIControlState.normal)
        
        
        title = shuffledDeck[0].question
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
