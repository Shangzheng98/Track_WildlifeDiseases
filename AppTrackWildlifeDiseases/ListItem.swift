//
//  ListItem.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import SwiftUI

struct ListItem: View {
    let record:Record
    var body: some View {
        HStack {
            getImageFromBinaryData(binaryData: record.photo!.photo ?? UIImage(named: "imageUnavailable")?.jpegData(compressionQuality: 1.0) , defaultFilename: "imageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100)
            VStack {
                Text(record.date ?? "not aviliable")
                
            }
        }
        .font(.system(size: 14))
    }
}


