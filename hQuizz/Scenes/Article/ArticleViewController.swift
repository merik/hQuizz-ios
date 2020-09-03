//
//  ArticleViewController.swift
//  hQuizz
//
//  Created by Erik Mai on 3/9/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {

   
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var closeLabel: UILabel!
    
    var articleUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(Self.didTapOnClose))
        closeLabel.isUserInteractionEnabled = true
        closeLabel.addGestureRecognizer(tap)
        closeLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        if let url = URL(string: articleUrl) {
            webView.load(URLRequest(url: url))
        }
        
        
    }
    
    @objc private func didTapOnClose() {
        dismiss(animated: true, completion: nil)
    }
   
}
