//
//  PictureTakeing.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI

struct PictureTakeing: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    let selectionList = ["Camera", "Library"]
    @State private var photoTakerIndex = 1
    @State private var photoImageData: Data? = nil
    @State private var showImagePicker = false
    @State private var date = Date()
    @State private var pickedAnswerIndex = 0
    let question = "How much you know about mange?"
    @State var choices = ["expert", "mediem", "poor"]
    
    @State var contactInformation = ""
    
    @State var showNoImageAlert = false
    @State var showSaveSuccessAlert = false
    var dateClosedRange: ClosedRange<Date> {
            // Set minimum date to 20 years earlier than the current year
            let minDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
           
            // Set maximum date to 2 years later than the current year
            let maxDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
            return minDate...maxDate
        }
    let tripCostFormatter: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 2
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.groupingSize = 3
            return numberFormatter
        }()
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    Text(question)
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.leading)
                    Picker(question, selection: $pickedAnswerIndex) {
                        ForEach(0 ..< choices.count, id: \.self) {
                            Text(self.choices[$0])
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                }
                Section(header: Text("Date")) {
                    DatePicker(
                        selection: $date,
                        in: dateClosedRange,
                        displayedComponents: .date) {
                            Text("Date")
                        }
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
                    .alert(isPresented: $showSaveSuccessAlert, content: {
                        saveSuccessAlert
                    })
                    
                }
                if photoImageData != nil {
                    Section(header: Text("contact information(optional)")){
                        TextEditor( text: $contactInformation)
                    }
                }
                
            }
            .navigationBarTitle("Record", displayMode: .inline)
            .navigationBarItems(trailing: Button (action: {
                save()
            }){
                Text("Upload")
            })
            .sheet(isPresented: self.$showImagePicker){
                PhotoCaptureView(showImagePicker: self.$showImagePicker, photoImageData: self.$photoImageData, cameraOrLibrary: self.selectionList[self.photoTakerIndex])
                
            }
            
            
        }
        
    }
    
    var saveSuccessAlert:Alert {
        Alert(title: Text("record Uploaded!"), message:Text("the record has uploaded successfully!"), dismissButton: .default(Text("OK")))
    }
    
    var photoImage:Image {
        if let imageData = self.photoImageData {
            let imageView = getImageFromBinaryData(binaryData: imageData, defaultFilename: "imageUnavailable")
            return imageView
        } else {
            return Image("imageUnavailable")
        }
    }
    
    func save() {
//        if self.photoImageData == nil {
//            showNoImageAlert = true
//            return
//        }
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self.date)
        let location = currentLocation()
        let newRecord = Record(context: self.managedObjectContext)
        newRecord.date = dateString
        newRecord.information = self.contactInformation
        newRecord.choice = self.choices[pickedAnswerIndex]
        newRecord.latitude = NSNumber(value: location.latitude)
        newRecord.longitude = NSNumber(value: location.longitude)
        newRecord.uuid = UUID().uuidString
        
        let newPhoto = Photo(context: self.managedObjectContext)
        if let imageData = self.photoImageData {
            newPhoto.photo = imageData
        } else {
            let photoUIImage = UIImage(named: "imageUnavailable")
           
            // Convert photoUIImage to data of type Data (Binary Data) in JPEG format with 100% quality
            let photoData = photoUIImage?.jpegData(compressionQuality: 1.0)
           
            // Assign photoData to Core Data entity attribute of type Data (Binary Data)
            newPhoto.photo = photoData!
        }
        
        newPhoto.record = newRecord
        newRecord.photo = newPhoto
        
         do {
            try self.managedObjectContext.save()
            uploadToStorageAndDataBase(record:newRecord)
            self.showSaveSuccessAlert = true
         } catch {
             return
         }
    }
    
    
}

struct choice: Codable, Hashable,Identifiable{
    var id: UUID = UUID()
    var content: String
    var isChecked: Bool = false
}


struct PictureTakeing_Previews: PreviewProvider {
    static var previews: some View {
        PictureTakeing()
    }
}
