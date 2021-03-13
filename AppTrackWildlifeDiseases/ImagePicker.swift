//
//  ImagePicker.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/23.
//

import Foundation
import SwiftUI
// Global variable
//var pickedImage = UIImage()

/*
 For storage and performance efficiency reasons, we scale down the
 album cover photo image selected by the user from the photo library
 or taken by camera to a smaller size, which is called a "thumbnail"
 */
let thumbnailImageWidth: CGFloat = 500.0
let thumbnailImageHeight: CGFloat = 500.0
 
 
/*
*************************************************
MARK: - Image Picker from Camera or Photo Library
*************************************************
*/
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage
    @Binding var isImageSelected: Bool
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType
  
//    func makeCoordinator() -> ImagePickerCoordinator {
//        return ImagePickerCoordinator(imagePickerShown: $imagePickerShown, photoImageData: $photoImageData)
//    }
  
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
      
        // Create a UIImagePickerController object, initialize it,
        // and store its object reference into imagePickerController
        let imagePickerControllor = UIImagePickerController()
        imagePickerControllor.allowsEditing = true
        imagePickerControllor.sourceType = sourceType
        imagePickerControllor.delegate = context.coordinator
        return imagePickerControllor
    }
  
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // Unused
    }
  
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(self)
    }
    
    
    final class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

      
        var parent:ImagePicker
      
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
            if let editedImage = info[.editedImage] as? UIImage {
                parent.selectedImage = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.selectedImage = originalImage
            } else {
                parent.selectedImage = UIImage()
                return
            }
            if parent.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(parent.selectedImage, nil, nil, nil)
            }
            parent.isImageSelected = true
            parent.presentationMode.wrappedValue.dismiss()
            // Scale the picked image to the thumbnail size for storage and performance efficiency reasons.
            // The scale() method is given below as an extension of the UIImage class.
          
    //        let thumbnailImage = pickedImage.scale(toSize: CGSize(width: thumbnailImageWidth, height: thumbnailImageHeight))
    //
    //        // jpegData returns a data object containing thumbnailImage in JPEG format.
    //        if let thumbnailData = thumbnailImage.jpegData(compressionQuality: 1.0) {
    //            /*
    //             🔴 Changing photoImageData value here is reflected in the @State private var photoImageData
    //                in calling view file because of the @Binding keyword.
    //             */
    //            photoImageData = thumbnailData
    //        } else {
    //            photoImageData = nil
    //        }
    //
    //        /*
    //        🔴 Changing imagePickerShown value here is reflected in the @State private var showImagePicker
    //           in calling view file because of the @Binding keyword.
    //        */
          
              
        }
      
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          
            picker.dismiss(animated: true, completion: nil)
        }
      
    }
}
 
/*
 ---------------------------------------------
 MARK: - Extension Methods to Resize a UIImage
 ---------------------------------------------
 */
 
// Resize a UIImage proportionately without distorting it
extension UIImage {
  
    func scale(toSize newSize:CGSize) -> UIImage {
        /*
         Make sure that the new size has the correct aspect ratio
         by calling the CGSize extension method resizeFill() below
        */
        let aspectFill = self.size.resizeFill(toSize: newSize)
      
        UIGraphicsBeginImageContextWithOptions(aspectFill, false, 0.0);
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: aspectFill.width, height: aspectFill.height)))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
      
        return newImage
    }
}
 
extension CGSize {
  
    func resizeFill(toSize: CGSize) -> CGSize {
        let scale : CGFloat = (self.height / self.width) < (toSize.height / toSize.width) ? (self.height / toSize.height) : (self.width / toSize.width)
        return CGSize(width: (self.width / scale), height: (self.height / scale))
    }
}
