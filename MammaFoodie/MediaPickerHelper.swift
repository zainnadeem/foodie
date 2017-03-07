//
//  MediaPickerHelper.swift
//  MammaFoodie
//
//  Created by Zain Nadeem on 2/27/17.
//  Copyright © 2017 MammaFoodieCorp. All rights reserved.
//

import UIKit
import MobileCoreServices

typealias MediaPickerHelperCompletion = ((Any?) -> Void)!

class MediaPickerHelper: NSObject {
    
    // MARK: - PROPERTIES
    weak var viewController: UIViewController!
    var completion: MediaPickerHelperCompletion
    
    // MARK: - INITIALIZERS
    init(viewController: UIViewController, completion: MediaPickerHelperCompletion) {
        self.viewController = viewController
        self.completion = completion
        
        super.init()
        
        self.showPhotoSourceSelection()
    }
    
    // MARK: - HELPER METHODS
    func showPhotoSourceSelection() {
        let actionSheet = UIAlertController(title: "Change Profile Picture", message: "", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take New Photo", style: .default, handler: {
            action in
            self.showImagePicker(sourceType: .camera)
        })
        
        let photosLibraryAction = UIAlertAction(title: "Choose from Photo Library", style: .default, handler: {
            action in
            self.showImagePicker(sourceType: .photoLibrary)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
            self.completion(nil)
        })
        
        actionSheet.addAction(photosLibraryAction)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cancelAction)
        
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
    func showImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        imagePicker.videoMaximumDuration = 30
        
        viewController.present(imagePicker, animated: true, completion: nil)
    }
}


// MARK: - UIImagePickerControllerDelegate
extension MediaPickerHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
        completion(nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        viewController.dismiss(animated: true, completion: nil)
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        if mediaType == kUTTypeImage as String {
            // photo
            let snapshotImage = info[UIImagePickerControllerEditedImage] as! UIImage
            completion(snapshotImage)
        } else {
            // video
            let videoURL = info[UIImagePickerControllerMediaURL] as! URL
            completion(videoURL)
        }
    }
}
