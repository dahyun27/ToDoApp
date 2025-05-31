//
//  Memo+CoreDataProperties.swift
//  ToDoApp
//
//  Created by 하다현 on 5/31/25.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64

}

extension Memo : Identifiable {

}
