//
//  NoteTableViewCell.swift
//  InClass08
//
//  Created by student on 7/28/16.
//  Copyright © 2016 MNR_iOS. All rights reserved.
//

import UIKit
import CoreData

class NoteTableViewCell: UITableViewCell {
    var tblView:UITableView?
    var delegateProp:UpdateNoteDelegate?
    var note:Note? {
        didSet {
            notesField?.text = note!.valueForKey("noteDescription") as? String
            let cDate = note!.valueForKey("createdDate") as? NSDate
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
            if cDate != nil {
                let dateString = formatter.stringFromDate(cDate!)
                dateField.text = dateString
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var notesField: UILabel!

    @IBOutlet weak var dateField: UILabel!
    
    @IBAction func deleteNote(sender: UIButton) {
        var indexPath: NSIndexPath!
        var indexPathRow = 0
        if let superview = sender.superview {
            if let cell = superview.superview as? NoteTableViewCell {
                indexPath = tblView!.indexPathForCell(cell)
                indexPathRow = indexPath.row
                delegateProp?.deleteNote(indexPathRow)
            }
        }
    }
}
