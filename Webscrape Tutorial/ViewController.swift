//
//  ViewController.swift
//  Webscrape Tutorial
//
//  Created by Will Ducharme on 6/14/18.
//  Copyright © 2018 DuCharme. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let webView = WKWebView()
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.gmail.com")!
        let request = URLRequest(url: url)
        webView.frame = CGRect(x: 0, y: 300, width: 300, height: 300)
        webView.load(request)
        view.addSubview(webView)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let emails = sender as AnyObject as? [Email],
            let emailsVC = segue.destination as? EmailsVC
            else {return}
        emailsVC.emails = emails
    }
    
    @IBAction func onSignInTapped() {
        switch counter {
        case 0:
            //Email enter
            webView.evaluateJavaScript("document.getElementById('Email').value='\(emailTF.text!)'", completionHandler: nil)
        case 1:
            //Email pass
            webView.evaluateJavaScript("document.getElementById('gaia_loginform').submit();", completionHandler: nil )
        case 2:
            //Password enter
            webView.evaluateJavaScript("document.getElementById('Passwd').value='\(passwordTF.text!)'", completionHandler: nil)
        case 3:
            //Password pass
            webView.evaluateJavaScript("document.getElementById('gaia_loginform').submit();", completionHandler: nil )
        case 4:
            //Handles case where extra screen comes up
            webView.reload()
        default:
            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler:
                { ( innerHTML, error) in
                    do {
                        let gmailResponse = try GmailResponse(innerHTML)
                        self.performSegue(withIdentifier: "ShowEmails", sender: gmailResponse.emails)
                    } catch{}
            })
        }
        counter += 1
    }
    
    
}

