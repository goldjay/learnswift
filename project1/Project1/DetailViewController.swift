//
//  DetailViewController.swift
//  Project1
//
//  Created by TwoStraws on 12/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit
import Social //Built in Twitter and Facebook functionality

class DetailViewController: UIViewController {
	@IBOutlet weak var imageView: UIImageView!
	var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

		title = selectedImage
        
        //Adds a sharing button to the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

		if let imageToLoad = selectedImage {
			imageView.image  = UIImage(named: imageToLoad)
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func shareTapped() {
        //Takes 2 parameters: items to share and other activities
        //let vc = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: [])
        //vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        //present(vc, animated: true)
        
        if let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
            vc.setInitialText("Some weather we're having")
            vc.add(imageView.image!)
            vc.add(URL(string: "http://photolib.noaa.gov/nssl"))
            present(vc, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
