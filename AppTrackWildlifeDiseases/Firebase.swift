//
//  File.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/25.
//

import Foundation
import Firebase
let storager = Storage.storage()

/// This function will upload the record to the cloud database, and will return the FIRStorageObservableTask reference.
/// - Parameter record: the reference of user record in the database
/// - Returns: FIRStorageObservableTask refenerce of the uploadTask.
public func uploadToStorageAndDataBase(record:Record) -> StorageUploadTask{
    
    let storagerRef = storager.reference()
    
    let imageRef = storagerRef.child("Mange/\(UUID().uuidString).jpg")
    //let semaphore = DispatchSemaphore(value: 0)
    let uploadTask = imageRef.putData(record.photo!.photo!, metadata: nil) { (metadata, err) in
        
        if err != nil {
            print("the url is wroing")
            //semaphore.signal()
            return
        }
      // You can also access to download URL after upload.
        imageRef.downloadURL { (url, error) in
            if err != nil {
                print("the url is wroing")
                //semaphore.signal()
                return
            }
            
            guard let url = url  else {
                print("the url is wroing")
                //semaphore.signal()
                return
                
            }
            let documentRef = Firestore.firestore().collection("users").document(record.uuid!)
            let urlString = url.absoluteString
            let data:[String: Any] = ["Date": record.date!,
                        "Contact Information": record.contactInformation!,
                        "Additional Information": record.additionalInformation!,
                        "Geo Info":[record.longitude!,record.latitude!],
                        "ImageURL":urlString,
                        "Choice": record.choice!,
                        "UUID": record.uuid!]
            documentRef.setData(data,completion: { (err) in
                if err != nil {
                    print("the url is wroing")
                    //semaphore.signal()
                    return
                }
                //semaphore.signal()
            })
      }
        
       // semaphore.signal()
        
        
    }
    //_ =  semaphore.wait(timeout: .now() + 10)
    return uploadTask
}
