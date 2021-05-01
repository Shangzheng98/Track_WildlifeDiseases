//
//  Record.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import Foundation
import CoreData

/// This is the structure of  record of the database.
public class Record: NSManagedObject, Identifiable {
    @NSManaged public var uuid:String?
    @NSManaged public var date: String?
    @NSManaged public var choice:String?
    @NSManaged public var contactInformation: String?
    @NSManaged public var additionalInformation:String?
    @NSManaged public var latitude:NSNumber?
    @NSManaged public var longitude:NSNumber?
    @NSManaged public var photo: Photo?
}



extension Record {
    
    /// This functuon will request all the information for the database.
    /// - Returns: <#description#>
    static func allRecordsFetchRequest() -> NSFetchRequest<Record> {
        let request:NSFetchRequest<Record> = Record.fetchRequest() as! NSFetchRequest<Record>
        
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false),
        ]
        return request
    }
    
}
