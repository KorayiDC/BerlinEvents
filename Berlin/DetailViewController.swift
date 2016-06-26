//
//  DetailViewController.swift
//  Berlin
//
//  Created by Koray Ece on 08.06.16.
//  Copyright © 2016 Koray Ece. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: [String: String]!
    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: {});
        
    }
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*  guard detailItem != nil else { return }
        
        if let body = detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
        }
        
 
        let instance = MasterViewController()
        
        */
        
        
        let NewUrl = NSURL(string: "https://www.google.de/maps/place/Berlin/")!
        let req = NSURLRequest(URL: NewUrl)
        self.webView.loadRequest(req)
        print(NewUrl)
        
        self.title = "Berlin"
        
    
    }
}