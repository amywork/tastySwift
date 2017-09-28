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
            // didTaskClosure?(username,password)
            // Plist에 파일 넣기 // 싱글톤 패턴 배우면 요렇게 쓰는 이유를 알게됨.
            // 영구적으로 저장함
            // userData 는 dictionary
            // userList는 dictionary를 담고 있는 배열
            var userList: [[String:String]]
            if let tempList = UserDefaults.standard.array(forKey: "UserList") as? [[String:String]] {
                userList = tempList
            }else {
                userList = []
            }
            let userData: [String:String] = ["ID":username, "PWD":password]
            userList.append(userData)
            UserDefaults.standard.set(userList, forKey: "UserList")
//  UserDefaults.standard.set(username, forKey: "ID")
//  UserDefaults.standard.set(password, forKey: "PWD")
//  UserDefaults.standard 싱글톤으로 여러가지 소스파일에서 모두 함 수 있도록 함
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
    }
    
}
