//
//  ToDoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by 하다현 on 5/31/25.
//
//

import Foundation
import CoreData


extension ToDoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
        return NSFetchRequest<ToDoData>(entityName: "ToDoData")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: Int64
    
    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.date else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }

}

extension ToDoData : Identifiable {

}
