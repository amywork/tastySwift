//
//  AddSubscriptionVC.swift
//  FinalStackProject
//
//  Created by 김기윤 on 24/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import Photos

class AddSubscriptionVC: UIViewController {

    // MARK: - UIProperty
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

}

/*Update UI Extension*/
extension AddSubscriptionVC {
    func updateUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.borderWidth = 1
        profileImageView.clipsToBounds = true
    }
}

/*Image Picker Extension*/
extension AddSubscriptionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Edit profile photo img
    @IBAction func editProfileImage(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "📷", message: "Change Profile", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let cameraAction = UIAlertAction(title: "카메라", style: .default) { (action) in
                let imgPicker = UIImagePickerController()
                imgPicker.sourceType = .camera
                imgPicker.delegate = self
                self.present(imgPicker, animated: true, completion: nil)
            }
            actionSheet.addAction(cameraAction)
        }
        
        let photoAction = UIAlertAction(title: "사진", style: .default) { (action) in
            let imgPicker = UIImagePickerController()
            imgPicker.sourceType = .photoLibrary
            imgPicker.delegate = self
            self.present(imgPicker, animated: true, completion: nil)
        }
        actionSheet.addAction(photoAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // didFinishPickingMediaWithInfo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let url = info[UIImagePickerControllerImageURL] as? URL {
            if let data = try? Data(contentsOf: url) {
                profileImageView.image = UIImage(data: data)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
