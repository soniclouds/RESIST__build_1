//
//  WebViewController.swift
//  RES!ST__v1
//
//  Created by soniclouds on 3/16/17.
//  Copyright © 2017 soniclouds. All rights reserved.
//

import UIKit
import CoreData

class WebViewController: UIViewController {
    
    weak var webViewDelegate: WebViewDelegate?
    var event: Event?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        webView.goBack()
    }
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        webView.goForward()
    }
    @IBAction func browserButtonPressed(_ sender: UIButton) {
        //        let url = URL(string: (event?.link)!)!
        //        let url = URL(string: "https://www.facebook.com/events/1416956705001322")
        let url = URL(string: (event?.link)!)
        UIApplication.shared.open(url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationController?.isNavigationBarHidden = false
        
        let url = NSURL (string: (event?.link)!)
        let request = NSURLRequest(url: url! as URL)
        print (request)
        webView.loadRequest(request as URLRequest)
        
        //        print(event?.link)
        //        print("printing event...: ", event!)
        print(event ?? "nil")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
