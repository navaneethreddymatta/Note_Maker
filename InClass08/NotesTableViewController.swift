//
//  NotesTableViewController.swift
//  InClass08
//
//  Created by student on 7/28/16.
//  Copyright © 2016 MNR_iOS. All rights reserved.
//

import UIKit
import CoreData

protocol UpdateNoteDelegate {
    func updateNote()
    func deleteNote(index : Int)
}

class NotesTableViewController: UITableViewController, UpdateNoteDelegate {
    var user:NSManagedObject?
    var userName:String?
    var userNotes:NSSet?
    var users = [NSManagedObject]()
    var usernotesArr:[Note]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNotes = user?.valueForKey("notes") as? NSSet
        usernotesArr = userNotes?.allObjects as? [Note]
        usernotesArr!.sortInPlace({ $0.createdDate!.compare($1.createdDate!) == NSComparisonResult.OrderedDescending })
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernotesArr!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userNotesCell", forIndexPath: indexPath)
        let note = usernotesArr![indexPath.row]
        if let appCell = cell as? NoteTableViewCell {
            appCell.note = note
            appCell.tblView = tableView
            appCell.delegateProp = self
        }
        // Configure the cell...

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let NoteVC = segue.destinationViewController as? NoteViewController {
            NoteVC.user = user
            //NoteVC.userName = user?.valueForKey("name") as? String
            NoteVC.delegateProp = self
        }
    }
    
    func updateNote() {
        userNotes = user?.valueForKey("notes") as? NSSet
        usernotesArr = userNotes?.allObjects as? [Note]
        usernotesArr!.sortInPlace({ $0.createdDate!.compare($1.createdDate!) == NSComparisonResult.OrderedDescending })
        tableView.reloadData()
    }
    
    func deleteNote(index : Int) {
        usernotesArr![index].user = nil
        usernotesArr?.removeAtIndex(index)
        userNotes = user?.valueForKey("notes") as? NSSet
        usernotesArr = userNotes?.allObjects as? [Note]
        usernotesArr!.sortInPlace({ $0.createdDate!.compare($1.createdDate!) == NSComparisonResult.OrderedDescending })
        tableView.reloadData()
        
    }

}
