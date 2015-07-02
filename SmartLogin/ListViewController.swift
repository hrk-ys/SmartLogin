//
//  ListViewController.swift
//  SmartLogin
//
//  Created by Hiroki Yoshifuji on 2015/06/30.
//  Copyright (c) 2015年 Hiroki Yoshifuji. All rights reserved.
//

import UIKit

class ListViewController : UITableViewController
{
    private var destinations: RLMResults!
    private var notification: RLMNotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinations = Destination.allObjects().sortedResultsUsingProperty("created_at", ascending: false)
        
        
        notification = RLMRealm.defaultRealm().addNotificationBlock({  [unowned self] (node, realm) -> Void in
            self.tableView.reloadData()
        })
        
        let backButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPathForCell(cell),
            let vc = segue.destinationViewController as? WebViewController,
            let destination = destinations[ UInt(indexPath.row) ] as? Destination {
                
                vc.destination = destination
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(destinations.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        if let destination = destinations[ UInt(indexPath.row) ] as? Destination {
            cell.textLabel?.text = destination.title
        }
        
        return cell
    }
    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if let destination = destinations[ UInt(indexPath.row) ] as? Destination {
                let realm = RLMRealm.defaultRealm()
                realm.beginWriteTransaction()
                realm.deleteObject(destination)
                realm.commitWriteTransaction()
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
