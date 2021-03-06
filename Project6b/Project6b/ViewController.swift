//
//  ViewController.swift
//  Project6b
//
//  Created by Jay Steingold on 10/23/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false //Disables auto-layout constraints
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        //Dictionary of views to be added
        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
        //Use instead of "magic numbers" to set heights and widths
        let metrics = ["labelHeight": 88]
        
        var previous: UILabel!
        
        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            
            //If there is a previous label, set the top anchor to the previous's bottom anchor
            if previous != nil {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor).isActive = true
            }
            
            previous = label
        }
        
        /*
        for label in viewsDictionary.keys {
            //Auto-layout method that converts VFL into an array of constraints
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: metrics, views: viewsDictionary))
                //"H" is horizontal
                // "|" is the edge of the view
                // Use viewDictionary to add the label itself into the formatting
        }
 
        
        //"V" is vertical
        //No second "|" if you don't want it to stretch
        //Label height set by (==88)
        //final label distance from bottom -(>=10)-|
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
 
        */
        
    }
    
    //Don't show the iOS status bar on this view controller
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

