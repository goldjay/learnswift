//
//  ViewController.swift
//  project4
//
//  Created by Jay Steingold on 10/5/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    //Progress bar view variable
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView(){
        webView = WKWebView()
        //Delegate is one thing acting in place of another.
        //When web page navigation happens, tell me
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        //New progress view instance
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        //Creates a new button item
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        //Who is the observer, property to be observed, which value we want and context value
        //#keypath allows your code to check if the property exists
        webView.addObserver(self, forKeyPath:
            #keyPath(WKWebView.estimatedProgress), options: .new, context:
            nil)
        
        
        //changes a string into a url
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of
        object: Any?, change: [NSKeyValueChangeKey : Any]?, context:
        UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func openTapped(){
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default,
                                       handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction!){
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    //Webview function to modify the webview window
    // Included in import
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    //Controls web navigation: allow or disallow navigation to happen
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler:
        @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url!.host {
            //Loop through approved websites to find the request url
            for website in websites {
                //Check if the url is found in a website url string
                if host.range(of: website) != nil {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        //If the website isn't found, cancel the action
        decisionHandler(.cancel)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

