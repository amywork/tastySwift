//
//  ProfileInfoViewController.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 25..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit


class ProfileInfoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet private weak var mainSc: UIScrollView!
    @IBOutlet private weak var profileImageView: UIImageView!
        
    @IBOutlet private weak var userIDTF: UITextField!
    @IBOutlet private weak var nickNameTF: UITextField!
    @IBOutlet private weak var msgTF: UITextField!
    @IBOutlet private weak var brithDayTF: UITextField!
    @IBOutlet private weak var phoneTF: UITextField!
    @IBOutlet private weak var emailTF: UITextField!

    @IBOutlet private weak var modifyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UI다듬기
        setUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showKeyboard), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
//        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (noti) in
//
//            if let keyboardFrame = noti.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect
//            {
//                self.mainSc.setContentOffset(CGPoint(x: 0, y:  keyboardFrame.height), animated: true)
//            }
//        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil) { (noti) in
            
            self.mainSc.setContentOffset(CGPoint(x: 0, y:  0), animated: true)
        }
        
    
    }
    
    @objc func showKeyboard(_ noti:Notification)
    {
        if let keyboardFrame = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        {
            self.mainSc.setContentOffset(CGPoint(x: 0, y:  keyboardFrame.height), animated: true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        textField.resignFirstResponder()
        
        return true
    }

    
    //ui다듬기
    private func setUI()
    {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.clipsToBounds = true
        
        modifyBtn.layer.cornerRadius = 20
        
        if let imgData = UserDefaults.standard.value(forKey:"profileImgData") as? Data
        {
            profileImageView.image = UIImage(data:imgData)
        }
    }
    
    
    @IBAction func modifyImgAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "골라", message: "초이스", preferredStyle: .actionSheet)
        
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

        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func modifyProfileAction(_ sender: UIButton) {
        //수정 버튼
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        
        
//        if let img =  info[UIImagePickerControllerOriginalImage] as? UIImage
//        {
//            profileImageView.image = img
//        }
      
        if let url = info[UIImagePickerControllerImageURL] as? URL
        {
            if let data = try? Data(contentsOf: url)
            {
                profileImageView.image = UIImage(data: data)
                
                UserDefaults.standard.set(data, forKey: "profileImgData")
            }
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}






//NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (noti) in
//    print()
//    if let keyboardFrame = noti.userInfo![UIKeyboardFrameBeginUserInfoKey] as? CGRect
//    {
//        self.mainSc.contentOffset = CGPoint(x: 0, y: keyboardFrame.height)
//    }
//
//}

