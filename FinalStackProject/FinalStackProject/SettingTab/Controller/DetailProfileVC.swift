//
//  DetailProfileVC.swift
//  FinalStackProject
//
//  Created by 김기윤 on 25/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import Photos

class DetailProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    // MARK: - UIProperty
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func doneBtnHandler(_ sender: UIButton) {
        
    }
    
    // MARK: - Edit profile photo img
    @IBAction func editProfileImage(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    // didFinishPickingMediaWithInfo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let newImg = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            profileImageView.image = newImg
//        }
        if let url = info[UIImagePickerControllerImageURL] as? URL {
            if let data = try? Data(contentsOf: url) {
                DataCenter.mainCenter.currentUser?.profileImageData = data
                profileImageView.image = UIImage(data: data)
            }
        }
        picker.dismiss(animated: true, completion: nil)
        
    }

}

extension DetailProfileVC: UITextFieldDelegate {
    
    private func updateUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        
        if let imageData = DataCenter.mainCenter.currentUser?.profileImageData {
            self.profileImageView.image = UIImage(data: imageData)
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (noti) in
            if let keyboardFrame = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                self.mainScrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height)
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: nil) { (noti) in
            self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
