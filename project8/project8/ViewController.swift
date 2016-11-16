//
//  ViewController.swift
//  project8
//
//  Created by Jay Steingold on 11/16/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solution = [String]()
    
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
    }
    
    func letterTapped(btn: UIButton) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

