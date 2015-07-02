//
//  RegistWebViewController.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/06/30.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import UIKit

class RegistWebViewController : TOWebViewController
{
    var destination:Destination!
    var requestURL: NSURL!
    
    private var maskView = UIView()
    private var registViewItaem:UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        maskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "close:"))
        if let views = NSBundle.mainBundle().loadNibNamed("RegistViewItem", owner: self, options: nil) as? [UIView] {
            registViewItaem = views[0]
            
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        }
        
        self.webView.loadRequest(NSURLRequest(URL: requestURL))
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
        destination.routes.removeAllObjects()
        tableView.reloadData()
    }
    
    @IBAction func edit(sender: AnyObject) {
        tableView.editing = !tableView.editing
    }
    @IBAction func regist(sender: AnyObject) {
        let realm = RLMRealm.defaultRealm()
        
        realm.beginWriteTransaction()
        realm.addObject(destination)
        realm.commitWriteTransaction()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tappedLeftBarButton(sender: AnyObject) {
        showRegistViewItem()
    }
}

extension RegistWebViewController : UIWebViewDelegate
{
    override func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        super.webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
        
        if request.URL?.absoluteString == request.mainDocumentURL?.absoluteString {
            
            if let req = request as? NSMutableURLRequest {
                destination.routes.addObject(Route.create(req))
                tableView.reloadData()
                println(destination)
            }
            
            println(request)
        }
        return true
    }
}

extension RegistWebViewController : UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(destination.routes.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        cell.textLabel?.numberOfLines = 0
        
        if let route = destination.routes[UInt(indexPath.row)] as? Route {
            cell.textLabel?.text = route.toString()
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            destination.routes.removeObjectAtIndex( UInt(indexPath.row) )
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
        }
    }
}