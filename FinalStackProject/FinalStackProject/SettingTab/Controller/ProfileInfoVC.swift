//
//  ProfileInfoVC.swift
//  FinalStackProject
//
//  Created by 김기윤 on 24/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import Photos

class ProfileInfoVC: UIViewController {
   
    // MARK: - UIProperty
    @IBOutlet weak var profileImageView: UIImageView!
    var currentUser = DataCenter.mainCenter.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}

extension ProfileInfoVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Accounts"
        }else if section == 1 {
            return "Subscriptions"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath)
        cell.textLabel?.text = currentUser?.userID
        cell.detailTextLabel?.text = "subscriptions info"
        return cell
    }
}


/*Update UI Extension*/
extension ProfileInfoVC {
    func updateUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.borderWidth = 1
        profileImageView.clipsToBounds = true
        
        if let imageData = DataCenter.mainCenter.currentUser?.profileImageData {
            self.profileImageView.image = UIImage(data: imageData)
        }
    }
}


/*Image Picker Extension*/
extension ProfileInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
                DataCenter.mainCenter.currentUser?.profileImageData = data
                profileImageView.image = UIImage(data: data)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
