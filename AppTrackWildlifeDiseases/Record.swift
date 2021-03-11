//
//  Record.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import Foundation
import CoreData

public class Record: NSManagedObject, Identifiable {
    @NSManaged public var uuid:String?
    @NSManaged public var date: String?
    @NSManaged public var choice:String?
    @NSManaged public var information: String?
    @NSManaged public var latitude:NSNumber?
    @NSManaged public var longitude:NSNumber?
    @NSManaged public var photo: Photo?
    @NSManaged public var uploadStatus:String?
}



extension Record {
    static func allRecordsFetchRequest() -> NSFetchRequest<Record> {
        let request:NSFetchRequest<Record> = Record.fetchRequest() as! NSFetchRequest<Record>
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false),
        ]
        return request
    }
    
}
