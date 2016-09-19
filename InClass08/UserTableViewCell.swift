//
//  UserTableViewCell.swift
//  InClass08
//
//  Created by student on 7/28/16.
//  Copyright © 2016 MNR_iOS. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var titleField: UILabel!
    
    @IBOutlet weak var dateField: UILabel!
    
}
