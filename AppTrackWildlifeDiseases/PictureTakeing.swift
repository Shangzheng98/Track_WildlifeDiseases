//
//  PictureTakeing.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI

struct PictureTakeing: View {
    let selectionList = ["Camera", "Library"]
    @State private var photoTakerIndex = 1
    @State private var photoImageData: Data? = nil
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header:Text("Date")) {
                    
                }
                
                Section(header: Text("add Image")) {
                    VStack {
                        Picker("Taker or Pick Photo", selection: $photoTakerIndex) {
                            ForEach(0 ..< selectionList.count, id:\.self) {
                                Text(self.selectionList[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                        Button(action: {
                            self.showImagePicker = true
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.up.on.square")
                                    .imageScale(.large)
                                Text("Get Photo")
                            }
                            .foregroundColor(.blue)
                        }
                        
                        photoImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height:150)
                    }
                    
                }
            }
            .navigationTitle("Upload")
            .sheet(isPresented: self.$showImagePicker){
                PhotoCaptureView(showImagePicker: self.$showImagePicker, photoImageData: self.$photoImageData, cameraOrLibrary: self.selectionList[self.photoTakerIndex])
                
            }
        }
        
    }
    
    
    var photoImage:Image {
        if let imageData = self.photoImageData {
            let imageView = getImageFromBinaryData(binaryData: imageData, defaultFilename: "ImageUnavailable")
            return imageView
        } else {
            return Image("ImageUnavailable")
        }
    }
    
}

struct PictureTakeing_Previews: PreviewProvider {
    static var previews: some View {
        PictureTakeing()
    }
}
