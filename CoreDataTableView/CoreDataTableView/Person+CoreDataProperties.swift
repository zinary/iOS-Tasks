//
//  Person+CoreDataProperties.swift
//  CoreDataTableView
//
//  Created by RamKumar on 16/01/20.
//  Copyright © 2020 Benseron. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
