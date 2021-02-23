//
//  RecordStruct.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import Foundation

struct RecordStruct: Hashable, Codable, Identifiable {
    var id:UUID
    var latitude: Double
    var longitude: Double
    var description: String
    var date:String
}
