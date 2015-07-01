//
//  Alert.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/07/02.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import Foundation

class Alert {
    
    class private func topViewController() -> UIViewController {
        let appDelegate = UIApplication .sharedApplication().delegate as! AppDelegate
        
        let rootVc = appDelegate.window!.rootViewController
        
        return self.findTopViewController(rootVc)!
    }
    
    class private func findTopViewController(controller: UIViewController?) -> UIViewController? {
        if let c = controller {
            if let navigationController = c as? UINavigationController {
                return findTopViewController(navigationController.visibleViewController)
            }
            
            if c.presentedViewController != nil {
                return findTopViewController(c.presentedViewController)
            }
        }
        
        return controller
    }
    
    class func showError(error: NSError) {
        var message = error.localizedDescription

        TSMessage.showNotificationInViewController(topViewController(), title: nil, subtitle: message, type: .Error)
    }
    class func showMessage(message: String) {
        TSMessage.showNotificationInViewController(topViewController(), title: nil, subtitle: message, type: .Message)
    }
    
    class func showSuccess(message: String) {
        TSMessage.showNotificationInViewController(topViewController(), title: nil, subtitle: message, type: .Success)
    }
    
    class func showWarning(message: String) {
        TSMessage.showNotificationInViewController(topViewController(), title: nil, subtitle: message, type: .Warning)
    }
}