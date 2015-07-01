//
//  RequestType.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/06/30.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import Foundation

class RequestType {
    var requestPath:   String!
    var requestMethod: String!
    
    func createRequest() -> NSMutableURLRequest? {
        if let URL = NSURL(string: requestPath) {
            var req  = NSMutableURLRequest(URL: URL)
            req.HTTPMethod = requestMethod
            return req
        }
        return nil;
    }
}

class PostRequestType: RequestType {
    var postBody: String!
    
    override func createRequest() -> NSMutableURLRequest? {
        if let req = super.createRequest() {
        
            if let body = postBody  {
                req.HTTPBody = (body as NSString).dataUsingEncoding(NSUTF8StringEncoding)
            }
            return req
        }
        return nil
    }
}