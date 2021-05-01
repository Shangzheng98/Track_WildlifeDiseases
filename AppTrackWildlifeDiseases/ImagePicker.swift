//
//  ImagePicker.swift
//  AppTrackWildlifeDiseases
//
//  Created by Shangzheng Ji on 2021/2/23.
//

import Foundation
import SwiftUI
import PhotosUI
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
              
        }
      
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          
            picker.dismiss(animated: true, completion: nil)
        }
      
    }
}

struct LibraryImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage
    @Binding var date: Date
    @Binding var location: CLLocationCoordinate2D
    
    @Environment(\.presentationMode) var presentationMode
    func makeUIViewController(context: Context) -> UIViewControllerType {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
            func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
                parent.presentationMode.wrappedValue.dismiss()
                guard !results.isEmpty else {
                    return
                }
                
                let imageResult = results[0]
                
                if let assetId = imageResult.assetIdentifier {
                    let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
                    DispatchQueue.main.async {
                        self.parent.date = (assetResults.firstObject?.creationDate) ?? Date()
                        if let coordinate  = assetResults.firstObject?.location?.coordinate {
                            self.parent.location = coordinate
                        }
                    }
                }
                if imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    imageResult.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            DispatchQueue.main.async {
                                self.parent.selectedImage = (selectedImage as? UIImage)!
                            }
                        }
                    }
                }
            }
            
            private let parent: LibraryImagePicker
            init(_ parent: LibraryImagePicker) {
                self.parent = parent
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
