//
//  NoteViewController.swift
//  InClass08
//
//  Created by student on 7/28/16.
//  Copyright © 2016 MNR_iOS. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {
    var user:NSManagedObject?
    var delegateProp:UpdateNoteDelegate?
    var userName:String?
    var users = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField?.text = user?.valueForKey("name") as? String
    }
    
    @IBOutlet weak var userNameField: UILabel!

    @IBOutlet weak var noteEditor: UITextView!
    
    @IBAction func cancelNoteCreation(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func saveNote(sender: AnyObject) {
        let description = noteEditor.text
        if description != nil && description != "" {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entityForName("Note", inManagedObjectContext: managedContext)
            let noteObj = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
            noteObj.setValue(description, forKey: "noteDescription")
            let cDate = NSDate()
            noteObj.setValue(cDate, forKey: "createdDate")
            noteObj.setValue(user, forKey: "user")
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error)")
            }
            delegateProp?.updateNote()
            self.dismissViewControllerAnimated(false, completion: nil)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Notes Cannot Be Empty", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
}
