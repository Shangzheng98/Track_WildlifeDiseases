//
//  PictureTakeing.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/19.
//

import SwiftUI
import Firebase
import Combine
import UIKit
import MapKit
struct PictureTakeing: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var photoImageData: Data? = nil
    @State private var image = UIImage()
    @State private var showCameraImagePicker = false
    @State private var showLibraryImagePicker = false
    @State private var date = Date()
    @State private var showActionSheet = false
    @State private var pickedAnswerIndex = -1
    @State private var showSaveErrorAlert = false
    @State private var choices:[Choice] = [Choice(name: "expert"),
                                           Choice(name: "mediem"),
                                           Choice(name: "poor")]
    
    @State private var contactInformation = ""
    
    @State private var showNoImageAlert = false
    @State private var showSaveSuccessAlert = false
    @State private var percentComplete:Double = 0.0
    @State private var isImageSelected = false
    @State private var choiceOnce = 0
    @State private var keyboardHeight:CGFloat = 0
    private let center = currentLocation()
    @State private var photoLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State private var sourceType:String = "camera"
    
    var dateClosedRange: ClosedRange<Date> {
        // Set minimum date to 20 years earlier than the current year
        let minDate = Calendar.current.date(byAdding: .year, value: -20, to: Date())!
       
        // Set maximum date to 2 years later than the current year
        let maxDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())!
        return minDate...maxDate
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Question").italic(), footer: Text("Slecet one choice")) {
                    VStack(alignment: .leading) {
                        Text(question)
                            .padding(.bottom, 10)
                        List {
                            ForEach(0..<choices.count) { index in
                                HStack {
                                    Button(action: {
                                        if choiceOnce == 0 {
                                            if choiceOnce < 1 {
                                                choices[index].isSelected = choices[index].isSelected ? false : true
                                                choiceOnce += 1
                                                pickedAnswerIndex = index
                                            }
                                        } else {
                                            if choiceOnce > 0 && choices[index].isSelected {
                                                choiceOnce = 0
                                                choices[index].isSelected = choices[index].isSelected ? false : true
                                                pickedAnswerIndex = -1
                                            }
                                        }
                                        
                                    }) {
                                        HStack {
                                            if choices[index].isSelected {
                                                Image(systemName: "app.fill")
                                                    .foregroundColor(Color("Chicago Maroon"))
                                                    .animation(.easeIn)
                                            } else {
                                                Image(systemName: "app")
                                                    .foregroundColor(Color("Chicago Maroon"))
                                                    .animation(.easeOut)
                                            }
                                            
                                            Text(choices[index].name)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                .padding(.bottom)
                            }
                        }
                    }
                }
                Section(header: Text("Pick a image")) {
                    
//                        Text("using right-up coner icon to add photo")
//                            .fixedSize(horizontal: true, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        Button(action: {
                            showActionSheet = true
                        }) {
                            if self.isImageSelected{
                                Image(uiImage:self.image)
                                    .resizable()
                                    .scaledToFit()
                            }
                            else {
                                ZStack(alignment: .center) {
                                    Image("Gray Image")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 180, maxHeight: 180)
                                        .padding()
                                        
                                    Image(systemName: "plus")
                                        .foregroundColor(.gray)
                                    
                                }
                                

                            }
                        }
                        .padding(.leading,20)
                        .sheet(isPresented: $showCameraImagePicker) {
                            ImagePicker(selectedImage:self.$image, isImageSelected: self.$isImageSelected, sourceType: .camera)
                        
                    }
                }
                Group {
                    if self.isImageSelected {
                        Section(header: Text("choose the date for the picture"), footer:Text("The default date is tody")) {
                            DatePicker(selection:$date, in:dateClosedRange,displayedComponents:.date) {
                                Text("select a date")
                            }
                        }
                        
                        Section(header: Text("Contact Info"), footer:
                                    Button(action: {UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to: nil,from: nil, for: nil) }) {
                                        Image(systemName: "keyboard")
                                            .font(Font.title.weight(.light))
                                            .foregroundColor(.blue)
                                        
                                    }){
                            TextEditor(text: $contactInformation)
                                .frame(height: 100)
                                .font(.custom("Helvetica", size: 14))
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.leading)
                                .onReceive(Publishers.keyboardHeight) {
                                    self.keyboardHeight = $0
                                }
                                
                                .padding(.bottom, keyboardHeight + 100)
                                
                        }
                        
                        
                        
                    }
                    
                    
                }
                .alert(isPresented: self.$showSaveErrorAlert) {
                    saveFailAlert
                }
                
                if self.sourceType == "library" {
                    Section(header: Text("Choose a location for the Image")) {
                        NavigationLink(destination:mapView(latitude: $photoLocation.latitude, longtitude: $photoLocation.longitude, locationLat: center.latitude, locationLong: center.longitude)) {
                            Text("Select a location")
                            
                        }
                        
                        Text("Lat: \(formatter(number: Double(photoLocation.latitude))) Long: \(formatter(number: Double(photoLocation.longitude)))")
                    }
                }
                

            }
            .sheet(isPresented: $showLibraryImagePicker) {
                ImagePicker(selectedImage:self.$image, isImageSelected: self.$isImageSelected, sourceType: .photoLibrary)
                
            }
            .actionSheet(isPresented: self.$showActionSheet) {
                ActionSheet(title: Text("Pick a picture"), buttons: [
                                .default(Text("Camera")){self.showCameraImagePicker = true
                                    self.sourceType = "camera"
                                },
                                .default(Text("Photo Library")){self.showLibraryImagePicker = true
                                    self.sourceType = "library"
                                },
                                .cancel()
                ])
            }
            .alert(isPresented: $showSaveSuccessAlert) {
                saveSuccessAlert
            }
            .navigationBarTitle("Record", displayMode: .inline)
            .navigationBarItems(trailing: Button (action: {
                //showActionSheet = true
                save()
            }){
                Text("Save")
                
            })
            
            
 
        }
        
    }
    
    var saveSuccessAlert:Alert {
        Alert(title: Text("Record Uploaded!"), message:Text("The record has uploaded successfully!"), dismissButton: .default(Text("OK")))
    }
    
    var saveFailAlert:Alert {
        Alert(title: Text("Record Upload failed"), message: Text("The record uploaded failed because of bad internet quality, you can upload late"), dismissButton: .default(Text("OK")))
    }
    func formatter(number: Double) -> String
    {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let n = Double(number)
        return formatter.string(from: NSNumber(value: n)) ?? "$0"
    }
    func save() {
//        if self.photoImageData == nil {
//            showNoImageAlert = true
//            return
//        }
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: self.date)
        let location = currentLocation()
        let newRecord = Record(context: self.managedObjectContext)
        newRecord.date = dateString
        newRecord.information = self.contactInformation
        newRecord.choice = pickedAnswerIndex == -1 ? "" : self.choices[pickedAnswerIndex].name
        if self.sourceType == "camera" {
            newRecord.latitude = NSNumber(value: location.latitude)
            newRecord.longitude = NSNumber(value: location.longitude)

        } else {
            newRecord.latitude = NSNumber(value: photoLocation.latitude)
            newRecord.longitude = NSNumber(value: photoLocation.longitude)
        }
                
        newRecord.uuid = UUID().uuidString
        
        let newPhoto = Photo(context: self.managedObjectContext)
        var  photoData:Data
        if self.isImageSelected {
            photoData = image.jpegData(compressionQuality: 0.8)!
            newPhoto.photo = photoData
        } else {
            let photoUIImage = UIImage(named: "ImageUnavailable")
            photoData = (photoUIImage?.jpegData(compressionQuality: 0.8))!
            newPhoto.photo = photoData
        }
        newPhoto.record = newRecord
        newRecord.photo = newPhoto
        
         
            
        let uploadTask = uploadToStorageAndDataBase(record:newRecord)
        uploadTask.observe(.progress) {
            snapshot in
            percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
        }
        uploadTask.observe(.success) { snapshot in
          // Upload completed successfully
            showSaveSuccessAlert = true
            uploadTask.removeAllObservers()
            print("uploadTask.observe(.success) called")
            do {
                try self.managedObjectContext.save()
            } catch {
                print("something wrong")
                return
            }
            
            
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {

                case .unknown:
                  // Unknown error occurred, inspect the server response
                    do  {
                        //try self.managedObjectContext.save()
                        uploadTask.cancel()
                        uploadTask.removeAllObservers()
                        self.showSaveErrorAlert = true
                        print("unknown error")
                    }

                  break
                default:
                  // A separate error occurred. This is a good place to retry the upload.
                    
                  break
                }
              }
        }
        //self.showSaveSuccessAlert = true
    }
    
    
}



extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat,Never> {
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map{
                $0.keyboardHeight
            }
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map {
                _ in CGFloat(0)
            }
        return Merge(willShow,willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
struct PictureTakeing_Previews: PreviewProvider {
    static var previews: some View {
        PictureTakeing()
    }
}

