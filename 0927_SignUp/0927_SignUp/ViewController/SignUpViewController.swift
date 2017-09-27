//
//  SignUpViewController.swift
//  0927_SignUp
//
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SignUpViewController: UIViewController {

    /*****Property*****/
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConformTextField: UITextField!
    // SignInViewController 에서 넘어올 클로저를 받을 변수
    var didTaskClosure: ((String, String) -> Void)? = nil
    
    /*****Action*****/
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let conformPwd = passwordConformTextField.text else { return }
        
        if password == conformPwd {
            didTaskClosure?(username,password)
            dismiss(animated: true, completion: nil) // 화면 내리기
        }else {
            print("회원가입에 실패하였습니다.")
        }
    }
    
    
    /*****ViewDidLoad*****/
    /*****Return Key addTarget*****/
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        passwordConformTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
    }
    
    
    // Exit Function
    @IBAction func didTapExitButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil) // 화면 내리기
    }
    
    /*****Keyboard 내리기 Function*****/
    @objc func didEndOnExit(_ sender: UITextField) {
        if usernameTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }else if passwordTextField.isFirstResponder {
            passwordConformTextField.becomeFirstResponder()
        }
    }
    
}
