//
//  UtilityFunction.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/24.
//

import Foundation
import SwiftUI
public func getImageFromBinaryData(binaryData: Data?, defaultFilename: String) -> Image {
   
    // Create a UIImage object from binaryData
    let uiImage = UIImage(data: binaryData!)
   
    // Unwrap uiImage to see if it has a value
    if let imageObtained = uiImage {
       
        // Image is successfully obtained
        return Image(uiImage: imageObtained)
       
    } else {
        /*
         Image file with name 'defaultFilename' is returned if the image cannot be obtained
         from binaryData given. Image file 'defaultFilename' must be given in Assets.xcassets
         */
        return Image(defaultFilename)
    }
}



