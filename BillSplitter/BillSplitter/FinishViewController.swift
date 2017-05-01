//
//  FinishViewController.swift
//  BillSplitter
//
//  Created by Jay Steingold on 5/1/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    var finalText = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        resultsLabel.text = finalText
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishClicked(_ sender: AnyObject) {
        if let navController = navigationController {
            
            navController.popToRootViewController(animated: true)
        }
    }
}
