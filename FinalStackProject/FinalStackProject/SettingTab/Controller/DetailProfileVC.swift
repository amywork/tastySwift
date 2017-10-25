//
//  DetailProfileVC.swift
//  FinalStackProject
//
//  Created by 김기윤 on 25/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class DetailProfileVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
    @IBAction func doneBtnHandler(_ sender: UIButton) {
        
    }
    
    @IBAction func editProfileImage(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) { (noti) in
            if let keyboardFrame = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                self.mainScrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.height)
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: nil) { (noti) in
            self.mainScrollView.contentOffset = CGPoint(x: 0, y: 0)
        }

    }
    
    private func updateUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
