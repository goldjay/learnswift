//
//  TutorialViewController.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 12/29/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    
    @IBOutlet weak var character: UILabel!
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var okayButton: UIButton!
    
    var deck: Deck?
    var num: Int?
    var cards: [[String]] = [[]]
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cards = (deck?.cards)!
        
        
        explanation.text = cards[count][2]
        character.text = cards[count][0]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prevTutorial(_ sender: AnyObject) {
        if(count - 1 >= 0){
            count -= 1
            explanation.text = cards[count][2]
            character.text = cards[count][0]
        }
    }
    
    @IBAction func nextTutorial(_ sender: AnyObject) {
        count += 1
        //If there are more tutorials left, reload the character and explanation
        if(count <= cards.count - 1){
            explanation.text = cards[count][2]
            character.text = cards[count][0]
        }
        //Otherwise, present the detailViewController
        else{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
                
                //CHANGE THIS FOR SAVING
                
                //For sending data back
                //vc.sendBack = self
                
                
                
                //Add condition to check if the deck has been completed.
                //If not, go to tutorialView first
                
                //Check if we have already completed
                
                    vc.selectedDeck = deck
                    vc.num = num
                    navigationController?.pushViewController(vc, animated: true)
            }

        }
        
        
        //Otherwise, return to the viewController
        //self.navigationController?.popToRootViewController(animated: true)
    
        //Otherwise present the detailviewcontroller
        
        //Pass the deck into the tutorialView as well as the tutorial info
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
