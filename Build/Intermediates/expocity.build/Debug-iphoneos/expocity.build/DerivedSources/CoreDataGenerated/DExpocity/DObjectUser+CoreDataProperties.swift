//
//  DObjectUser+CoreDataProperties.swift
//  
//
//  Created by zero on 10/10/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension DObjectUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DObjectUser> {
        return NSFetchRequest<DObjectUser>(entityName: "DObjectUser");
    }

    @NSManaged public var name: String?
    @NSManaged public var userId: String?

}
