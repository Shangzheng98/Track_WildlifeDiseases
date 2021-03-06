//
//  Photo.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import Foundation
import CoreData

public class Photo: NSManagedObject, Identifiable {
    @NSManaged public var photo: Data?
    @NSManaged public var record:Record?
}
