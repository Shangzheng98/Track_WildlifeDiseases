//
//  Photo.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import Foundation
import CoreData

/// This structure of the Photo in the database
public class Photo: NSManagedObject, Identifiable {
    @NSManaged public var photo: Data?
    @NSManaged public var record:Record?
}
