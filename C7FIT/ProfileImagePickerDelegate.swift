//
//  ProfileImagePickerDelegate.swift
//  C7FIT
//
//  Created by Brandon Lee on 4/9/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import MobileCoreServices

// MARK: - UIImagePickerControllerDelegate

/// Adapter Pattern for UIImagePickerController
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let mediaType: String = info[UIImagePickerControllerMediaType] as? String else {
            dismiss(animated: true, completion: nil)
            return
        }

        // Make sure media is an image, if so upload it and update download URL
        if mediaType == (kUTTypeImage as String) {
            if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage,
                let imageData = UIImageJPEGRepresentation(originalImage, 0.8) {
                guard let userID = self.userID else { return }
                firebaseDataManager.uploadProfilePicture(uid: userID, data: imageData, completion: { (url) in
                    guard let url = url else { return }
                    self.profileURL = url
                    self.updateprofileImage(url: url)
                })
            }
        }

        dismiss(animated: true, completion: nil)
    }
}
