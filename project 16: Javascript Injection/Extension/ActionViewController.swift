//
//  ActionViewController.swift
//  Extension
//
//  Created by Jay Steingold on 3/20/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .done, target: self,
                            action: #selector(done))
        
        if let inputItem = extensionContext!.inputItems.first as?
            NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first as?
                NSItemProvider {
                itemProvider.loadItem(forTypeIdentifier:
                kUTTypePropertyList as String) { [unowned self] (dict, error)
                    in
                    
                    let itemDictionary = dict as! NSDictionary
                    let javaScriptValues =
                        itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey]
                            as! NSDictionary
                    self.pageTitle = javaScriptValues["title"] as! String
                    self.pageURL = javaScriptValues["URL"] as! String
                    DispatchQueue.main.async {
                        self.title = self.pageTitle
                    }
                }
            }
        }
    
    }
    
    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript":
            script.text]
        let webDictionary: NSDictionary =
            [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary,
                                              typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext!.completeRequest(returningItems: [item])
    }

}
