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
    
    var c: String?
    var ex: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        character.text = c
        explanation.text = ex
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nextTutorial(_ sender: AnyObject) {
        //If there are more tutorials left, reload the character and explanation
        
        
        //Otherwise, return to the viewController
        self.navigationController?.popToRootViewController(animated: true)
    
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
