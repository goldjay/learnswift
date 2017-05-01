//
//  ViewController.swift
//  BillSplitter
//
//  Created by Jay Steingold on 4/30/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var dinersTF: UITextField!

    @IBOutlet weak var costTF: UITextField!
    
    var resultText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        view.endEditing(true) // Everything is done and you can dismiss
    }
    
    // Check values to make sure segue is okay
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let dinerStr = dinersTF.text, let totalStr = costTF.text, let diner = Double(dinerStr), let total = Double(totalStr) {
            
            let formattedCost = String(format: "%.2f", total)
            let formattedTotal = String(format: "%.2f", total / diner)
            
            resultText = "The total cost of dinner is $\(formattedCost). \n There were \(Int(diner)) diners. \n It is $\(formattedTotal) per person."
            
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let desinationVC = segue.destination as! ResultsViewController
            
            desinationVC.finalText = resultText
            
            
            
    }
}


