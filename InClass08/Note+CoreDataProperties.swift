//
//  Note+CoreDataProperties.swift
//  InClass08
//
//  Created by student on 7/28/16.
//  Copyright © 2016 MNR_iOS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Note {

    @NSManaged var noteDescription: String?
    @NSManaged var createdDate: NSDate?
    @NSManaged var user: User?

}
