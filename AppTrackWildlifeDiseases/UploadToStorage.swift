//
//  File.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/25.
//

import Foundation
import Firebase
public func uploadToStorageAndDataBase(record:Record) -> StorageUploadTask{
    let storagerRef = Storage.storage().reference()
    let imageRef = storagerRef.child("Mange/\(UUID().uuidString).jpg")
    //let semaphore = DispatchSemaphore(value: 0)
    let uploadTask = imageRef.putData(record.photo!.photo!, metadata: nil) { (metadata, err) in
        
        if let error = err {
            print("error: \(error.localizedDescription)")
            //semaphore.signal()
            return
        }
      // You can also access to download URL after upload.
        imageRef.downloadURL { (url, error) in
            if let error = err {
                print("error: \(error.localizedDescription)")
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
                        "Contact Information": record.information!,
                        "Geo Info":[record.latitude!,record.longitude!],
                        "URL1":urlString,
                        "Choice": record.choice!,
                        "uuid": record.uuid!]
            documentRef.setData(data,completion: { (err) in
                if let err = err {
                    print("error: \(err.localizedDescription)")
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
