//
//  Route.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/07/02.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import Foundation

class Route: RLMObject {
    dynamic var url     = ""
    dynamic var method  = ""
    dynamic var content = ""
    
    
    class func create(request: NSMutableURLRequest) -> Route {
        var route = Route()
        
        if
            let URL = request.URL,
            let urlString = URL.absoluteString
        {
            route.url = urlString
        }
        route.method = request.HTTPMethod
        if
            let body = request.HTTPBody,
            let content = NSString(data:body, encoding:NSUTF8StringEncoding)
        {
            route.content = content as String
        }
        
        return route
    }
    
    func request() -> NSMutableURLRequest? {
        
        if let URL = NSURL(string: url) {
            var req  = NSMutableURLRequest(URL: URL)
            
            req.HTTPMethod = method
            
            if !content.isEmpty  {
                req.HTTPBody = (content as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            }
            
            return req
        }
        return nil;
    }
    
    func toString() -> String {
        return "\(method) \(url)\n\(content)"
    }
}