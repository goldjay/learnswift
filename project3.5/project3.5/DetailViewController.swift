//
//  DetailViewController.swift
//  project3.5
//
//  Created by Jay Steingold on 10/27/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedImage
        
        //Adds a sharing button to the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        
        
        if let imageToLoad = selectedImage {
            imageView.layer.borderWidth = 2
            imageView.image  = UIImage(named: imageToLoad)
            
        }
    }
    
    func shareTapped() {
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            vc.setInitialText("Wow, look at this flag!")
            vc.add(imageView.image!)
            //vc.add(URL(string: "http://photolib.noaa.gov/nssl"))
            present(vc, animated: true)
        }
        
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
