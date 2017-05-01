//
//  ResultsViewController.swift
//  BillSplitter
//
//  Created by Jay Steingold on 4/30/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultsLabel: UILabel!
    
    var finalText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsLabel.text = finalText

        // Do any additional setup after loading the view.
    }

    /*
    @IBAction func dismissResults(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }
    */
    
    

}
