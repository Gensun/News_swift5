//
//  TeMaiViewController.swift
//  HeadNews
//
//  Created by Cheng Sun on 7/29/19.
//  Copyright © 2019 EF. All rights reserved.
//

import UIKit
import WebKit

class TeMaiViewController: UIViewController {

    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let webView = WKWebView(frame: view.bounds, configuration: WKWebViewConfiguration())
        webView.load(URLRequest(url: URL(string: url)!))
        view.addSubview(webView)
    }
}
