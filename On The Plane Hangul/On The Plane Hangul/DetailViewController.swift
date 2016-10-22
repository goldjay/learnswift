//
//  DetailViewController.swift
//  On The Plane Hangul
//
//  Created by Jay Steingold on 10/8/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var deckNum: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load and create the decks
        
        //One deck for questions and another for answers
        
        //Create askquestion method

        title = String(deckNum!)
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
