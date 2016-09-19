//
//  UsersTableViewController.swift
//  InClass08
//
//  Created by student on 7/28/16.
//  Copyright © 2016 MNR_iOS. All rights reserved.
//

import UIKit
import CoreData

protocol UpdateValueDelegate {
    func updateValue()
}

class UsersTableViewController: UITableViewController, UpdateValueDelegate {
    var users = [NSManagedObject]()
    var selectedUser:NSManagedObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            users = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath)
        
        let user = users[indexPath.row]
        if let appCell = cell as? UserTableViewCell {
            appCell.titleField.text = user.valueForKey("name") as? String
            let cDate = user.valueForKey("createdDate") as? NSDate
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            if cDate != nil {
                let dateString = formatter.stringFromDate(cDate!)
                appCell.dateField.text = dateString
            }
        }
        // Configure the cell...
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "userDetails" {
            if let UserVC = segue.destinationViewController as? UserViewController {
                UserVC.delegateObj = self
            }
        } else if segue.identifier == "userNotes" {
            if let UserVC = segue.destinationViewController as? NotesTableViewController {
                let selectedIndex = self.tableView.indexPathForCell(sender as! UserTableViewCell)
                let selectedUser = users[selectedIndex!.row]
                UserVC.user = selectedUser
                //UserVC.userName = selectedUser.valueForKey("name") as? String
                UserVC.navigationItem.title = "\((selectedUser.valueForKey("name") as? String)!) Notes"
            }
        }
    }
    
    func updateValue() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            users = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        tableView.reloadData()
    }
}