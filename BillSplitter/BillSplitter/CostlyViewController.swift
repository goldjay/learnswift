//
//  CostlyViewController.swift
//  BillSplitter
//
//  Created by Jay Steingold on 4/30/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class CostlyViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    var finalTextCostly = ""
    var titleCostly = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsLabel.text = finalTextCostly
        titleLabel.text = titleCostly
        

        // Do any additional setup after loading the view.
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
