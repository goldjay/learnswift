//
//  ViewController.swift
//  Project15
//
//  Created by Jay Steingold on 3/20/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!
    var currentAnimation = 0
    @IBOutlet weak var tap: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Centers penguin image in bounds
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapped(_ sender: AnyObject) {
        
        // Hides the button
        tap.isHidden = true
        
        // Added springWithDamping for spring-style animation
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
                       animations: { [unowned self] in
                        switch self.currentAnimation {
                        case 0:
                            self.imageView.transform = CGAffineTransform(scaleX: 2, y:
                                2)
                        case 1:
                            // Resets any scaling done to the default
                            self.imageView.transform = CGAffineTransform.identity
                        case 2:
                            self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                        case 3:
                            self.imageView.transform = CGAffineTransform.identity
                        case 4:
                            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                        case 5:
                            self.imageView.transform = CGAffineTransform.identity
                        case 6:
                            self.imageView.alpha = 0.1
                            self.imageView.backgroundColor = UIColor.green
                        case 7:
                            self.imageView.alpha = 1
                            self.imageView.backgroundColor = UIColor.clear
                        default:
                            break
                        }
        // On completion of animation, unhides button
        }) { [unowned self] (finished: Bool) in
            self.tap.isHidden = false
        }
        currentAnimation += 1
        if currentAnimation > 7 {
            currentAnimation = 0
        }
        
    }

}

