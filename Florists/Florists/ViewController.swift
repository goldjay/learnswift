//
//  ViewController.swift
//  Florists
//
//  Created by Jay Steingold on 1/27/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var sampleButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    //CALLED EVERY TIME VIEW APPEARS
    override func viewWillAppear(_ animated: Bool) {
        topLabel.text = "Buy from us!"
        infoLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let myImage = UIImageView()
//        myImage.frame = CGRect(x: 10, y: 70, width: 60, height: 60)
//        myImage.image = UIImage(named: "1")
//        myImage.contentMode = UIViewContentMode.scaleAspectFill
//        myImage.center = CGPoint(x: self.view.frame.width/2, y: 110)
//        
//        
//        view.addSubview(myImage)
        
        topLabel.text = "Buy flowers"
        
        sampleButton.setTitle("Seriously", for: .normal)
        
    }
   
    @IBAction func facebookClicked(_ sender: AnyObject) {
        
        print("Facebook button was clicked")
        
        topLabel.text = "Facebook info"
        infoLabel.text = "This is our facebook information"
        
        
    }

    @IBAction func youtubeClicked(_ sender: AnyObject) {
        
        print("Youtube button was clicked")
        
        topLabel.text = "youtube info"
        infoLabel.text = "This is our youtube information"
    }
    @IBAction func twitterClicked(_ sender: AnyObject) {
        
        topLabel.text = "Twitter info"
        infoLabel.text = "This is our Twitter information"
        
        print("Twitter button was clicked")
    }
    
}

