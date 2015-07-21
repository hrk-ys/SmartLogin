//
//  WebViewController.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/06/30.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import UIKit

class WebViewController : TOWebViewController
{
//    var requestItems:[RequestType] = []
    var destination : Destination!
    private var routeIndex = UInt(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//
//
//        var r1 = RequestType()
//        r1.requestPath = "http://g-schedule.com/"
//        r1.requestMethod = "GET"
//        requestItems.append(r1)
//        
//        var r2 = PostRequestType()
//        r2.requestPath = "http://g-schedule.com/cgi-bin/g_menu.cgi"
//        r2.requestMethod = "Post"
//        r2.postBody    = "mode=check&gid=34172&num=0&pas=1232&button=%83%8D%83O%83C%83%93"
//        
//        requestItems.append(r2)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer.delegate = self
        
        request()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer.delegate = nil
    }
    
    private func request() {
        
        if routeIndex < destination.routes.count {
            
            if let route = destination.routes[routeIndex] as? Route {
                
                if let req = route.request() {
                    webView.loadRequest(req)
                }
            }
            
            routeIndex++
            
            let delay = 1.0 * Double(NSEC_PER_SEC)
            let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue(), {
                self.request()
            })
        }
    }
}

extension WebViewController : UIGestureRecognizerDelegate
{
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

extension WebViewController : UIWebViewDelegate
{
    override func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        super.webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
        
        if request.mainDocumentURL?.absoluteString == request.URL?.absoluteString {
            println(request)
        }
        return true
    }

    override func webViewDidFinishLoad(webView: UIWebView) {
        super.webViewDidFinishLoad(webView)
    }
}