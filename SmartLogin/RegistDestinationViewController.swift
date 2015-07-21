//
//  RegistDestinationViewController.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/07/03.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import UIKit

class RegistDestinationViewController : UIViewController
{
    
    @IBOutlet weak var titleTextLabel: UITextField!
    @IBOutlet weak var urlTextLabel: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextLabel.becomeFirstResponder()
        urlTextLabel.text = "http://g-schedule.com/"
    }
    
    private func updateLayout() {
        nextButton.enabled = validate()
    }
    
    private func validate() -> Bool {
        if urlTextLabel.text.isEmpty ||
            titleTextLabel.text.isEmpty {
            return false
        }
        
        if let url = NSURL(string: urlTextLabel.text) {
            return true
        }
        return false
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        if titleTextLabel.text.isEmpty {
            Alert.showWarning("タイトルを入力してください")
            titleTextLabel.becomeFirstResponder()
            return false
        }
        
        if urlTextLabel.text.isEmpty {
            Alert.showWarning("URLを入力してください")
            urlTextLabel.becomeFirstResponder()
            return false
        }
        
        if NSURL(string: urlTextLabel.text) == nil{
            Alert.showWarning("URLに不備があります")
            urlTextLabel.becomeFirstResponder()
            return false
        }
        
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? RegistWebViewController {
            
            var destination = Destination()
            destination.title = titleTextLabel.text
            vc.destination = destination
            vc.requestURL  = NSURL(string: urlTextLabel.text)
        }
    }
    
    
}

