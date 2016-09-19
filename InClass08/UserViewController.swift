//
//  UserViewController.swift
//  InClass08
//
//  Created by student on 7/28/16.
//  Copyright © 2016 MNR_iOS. All rights reserved.
//

import UIKit
import CoreData

class UserViewController: UIViewController {
    var delegateObj:UpdateValueDelegate?
    var users = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var userNameField: UITextField!
    
    @IBAction func cancelUserCreation(sender: UIButton) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func addUser(sender: UIButton) {
        let name = userNameField.text
        if name != nil && name != "" {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
            let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
            person.setValue(name, forKey: "name")
            
            
            let cDate = NSDate()
            person.setValue(cDate, forKey: "createdDate")
            do {
                try managedContext.save()
                //people.append(person)
            } catch let error as NSError  {
                print("Could not save \(error)")
            }
            let fetchRequest = NSFetchRequest(entityName: "User")
            do {
                let results = try managedContext.executeFetchRequest(fetchRequest)
                users = results as! [NSManagedObject]
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
            users.append(person)
            delegateObj!.updateValue()
            self.dismissViewControllerAnimated(false, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Name Cannot Be Empty", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

}
