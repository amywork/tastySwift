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
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var conformPwd: UITextField!
    
    // SignInViewController 에서 넘어올 클로저를 받을 변수
    var didTaskClosure: ((String, String) -> Void)? = nil
    
    /*****Action*****/
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard let username = username.text else { return }
        guard let password = password.text else { return }
        guard let conformPwd = conformPwd.text else { return }
        if password == conformPwd {
            didTaskClosure?(username,password)
            dismiss(animated: true, completion: nil) // 화면 내리기
        }else {
            print("failed")
        }
    }
    
    // Exit Action
    @IBAction func didTapExitButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil) // 화면 내리기
    }
    
    /*****ViewDidLoad*****/
    /*****Return Key addTarget*****/
    override func viewDidLoad() {
        super.viewDidLoad()
        username.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        password.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        conformPwd.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
    }
    
    /*****Keyboard 내리기 Function*****/
    @objc func didEndOnExit(_ sender: UITextField) {
        if username.isFirstResponder {
            password.becomeFirstResponder()
        }else if password.isFirstResponder {
            conformPwd.becomeFirstResponder()
        }
//        if sender === username { // username에는 메모리 주소가 들어있음, 인스턴스 비교는 ===
//            password.becomeFirstResponder()
//        }else if sender == password {
//            conformPwd.becomeFirstResponder()
//        }
    }
    
}
