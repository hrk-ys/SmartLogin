//
//  RegistViewController.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/06/30.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import UIKit

class RegistViewController : TOWebViewController
{
    private var maskView = UIView()
    private var registViewItaem:UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        maskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "close:"))
        if let views = NSBundle.mainBundle().loadNibNamed("RegistViewItem", owner: self, options: nil) as? [UIView] {
            registViewItaem = views[0]
        }
    }
    
    private func showRegistViewItem() {
        let registVIewItemHeight = CGFloat(self.view.bounds.size.height * 2 / 3)
        maskView.frame = self.view.bounds
        maskView.alpha = 0
        registViewItaem.frame = CGRectMake(0, self.view.frame.height, self.view.frame.size.width, registVIewItemHeight)
        
        self.navigationController!.view.addSubview(maskView)
        self.navigationController!.view.addSubview(registViewItaem)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.maskView.alpha = 1
            self.registViewItaem.frame = CGRectOffset(self.registViewItaem.frame, 0, -registVIewItemHeight)
        })
    }
    
    private func closeRegistViewItem() {
        let registVIewItemHeight = CGFloat(self.view.bounds.size.height * 2 / 3)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.maskView.alpha = 0
            self.registViewItaem.frame = CGRectMake(0, self.view.frame.height, self.view.frame.size.width, registVIewItemHeight)
        }) { (completed) -> Void in
            self.maskView.removeFromSuperview()
            self.registViewItaem.removeFromSuperview()
        }
    }
    
    @IBAction func close(sender: AnyObject) {
        closeRegistViewItem()
    }
    
    @IBAction func clear(sender: AnyObject) {
    }
    
    @IBAction func regist(sender: AnyObject) {
    }
    
    @IBAction func tappedLeftBarButton(sender: AnyObject) {
        showRegistViewItem()
    }
}

extension RegistViewController : UISearchBarDelegate
{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let URL = NSURL(string: searchBar.text) {
            self.webView.loadRequest(NSURLRequest(URL: URL))
            searchBar.resignFirstResponder()
            closeRegistViewItem()
        }
    }
}

extension RegistViewController : UIWebViewDelegate
{
    override func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        super.webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
        
        if request.URL?.absoluteString == request.mainDocumentURL?.absoluteString {
            
            println(request)
        }
        return true
    }

}