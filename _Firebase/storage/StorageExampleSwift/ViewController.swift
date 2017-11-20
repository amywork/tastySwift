//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import Photos
import Firebase

@objc(ViewController)
class ViewController: UIViewController,
                      UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var takePicButton: UIButton!
  @IBOutlet weak var downloadPicButton: UIButton!
  @IBOutlet weak var urlTextView: UITextField!

  var storageRef: StorageReference!

  override func viewDidLoad() {
    super.viewDidLoad()

    // [START configurestorage]
    storageRef = Storage.storage().reference()
    // [END configurestorage]

    // [START storageauth]
    // Using Cloud Storage for Firebase requires the user be authenticated. Here we are using
    // anonymous authentication.
    if Auth.auth().currentUser == nil {
      Auth.auth().signInAnonymously(completion: { (user: User?, error: Error?) in
        if let error = error {
          self.urlTextView.text = error.localizedDescription
          self.takePicButton.isEnabled = false
        } else {
          self.urlTextView.text = ""
          self.takePicButton.isEnabled = true
        }
      })
    }
    // [END storageauth]
  }

  // MARK: - Image Picker

  @IBAction func didTapTakePicture(_: AnyObject) {
    let picker = UIImagePickerController()
    picker.delegate = self
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      picker.sourceType = .camera
    } else {
      picker.sourceType = .photoLibrary
    }

    present(picker, animated: true, completion:nil)
  }

  func imagePickerController(_ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [String : Any]) {
      picker.dismiss(animated: true, completion:nil)

    urlTextView.text = "Beginning Upload"
    // if it's a photo from the library, not an image from the camera
    if #available(iOS 8.0, *), let referenceUrl = info[UIImagePickerControllerReferenceURL] as? URL {
      let assets = PHAsset.fetchAssets(withALAssetURLs: [referenceUrl], options: nil)
      let asset = assets.firstObject
      asset?.requestContentEditingInput(with: nil, completionHandler: { (contentEditingInput, info) in
        let imageFile = contentEditingInput?.fullSizeImageURL
        let filePath = Auth.auth().currentUser!.uid +
          "/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\(imageFile!.lastPathComponent)"
        // [START uploadimage]
        self.storageRef.child(filePath)
          .putFile(from: imageFile!, metadata: nil) { (metadata, error) in
            if let error = error {
              print("Error uploading: \(error)")
              self.urlTextView.text = "Upload Failed"
              return
            }
            self.uploadSuccess(metadata!, storagePath: filePath)
        }
        // [END uploadimage]
      })
    } else {
      guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
      guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
      let imagePath = Auth.auth().currentUser!.uid +
        "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
      let metadata = StorageMetadata()
      metadata.contentType = "image/jpeg"
      self.storageRef.child(imagePath).putData(imageData, metadata: metadata) { (metadata, error) in
        if let error = error {
          print("Error uploading: \(error)")
          self.urlTextView.text = "Upload Failed"
          return
        }
        self.uploadSuccess(metadata!, storagePath: imagePath)
      }
    }
  }

  func uploadSuccess(_ metadata: StorageMetadata, storagePath: String) {
    print("Upload Succeeded!")
    self.urlTextView.text = metadata.downloadURL()?.absoluteString
    UserDefaults.standard.set(storagePath, forKey: "storagePath")
    UserDefaults.standard.synchronize()
    self.downloadPicButton.isEnabled = true
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion:nil)
  }
}
