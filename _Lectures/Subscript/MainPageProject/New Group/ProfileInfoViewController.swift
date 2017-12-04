//
//  ProfileInfoViewController.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 25..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class ProfileInfoViewController: UIViewController, UITextFieldDelegate {

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
        
        modifyBtn.layer.cornerRadius = 20
    }
    
    
    @IBAction func modifyImgAction(_ sender: Any) {
    }
    
    @IBAction func modifyProfileAction(_ sender: UIButton) {
        //수정 버튼
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

