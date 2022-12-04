//
//  TvSeriesWebViewController.swift
//  SayMyName
//
//  Created by Emin Saygı on 26.11.2022.
//

import UIKit
import WebKit


class TvSeriesWebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string : "https://www.imdb.com/title/tt0903747")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    
        
    }
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    
    
    
}
