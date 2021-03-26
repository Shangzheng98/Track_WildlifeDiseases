//
//  File.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/25.
//

import Foundation
import Firebase
let storager = Storage.storage()

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
                        "Contact Information": record.information!,
                        "Geo Info":[record.longitude!,record.latitude!],
                        "URL1":urlString,
                        "Choice": record.choice!,
                        "uuid": record.uuid!]
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


public func updateJSonFileFromFirebase() {
    let mangeJsonRef = storager.reference(withPath:"gs://apptrackwildlifediseases-388bf.appspot.com/mange.json")
    let profileJsonRef = storager.reference(withPath: "gs://apptrackwildlifediseases-388bf.appspot.com/profile.json")
    let projectJsonRef = storager.reference(withPath: "gs://apptrackwildlifediseases-388bf.appspot.com/project.json")
    
    mangeJsonRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
      if let error = error {
        // Uh-oh, an error occurred!
      } else {
        // Data for "images/island.jpg" is returned
        
      }
    }
    
    
}
