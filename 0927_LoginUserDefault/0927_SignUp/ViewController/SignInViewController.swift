//
//  SignInViewController.swift
//  0927_SignUp
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    
    override func loadView() {
        super.loadView()
        print("SignInViewController loadView")
    }
    
    
    var userModel = UserModel()
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SignInViewController viewDidLoad")
        // Keyboard 내리기
        usernameTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        loginButton.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
    }

    // SignIn 버튼을 눌렀을 때
    @IBAction func didTapLoginButton(_ sender: RoundButton) {
        guard let username = usernameTextField.text, !username.isEmpty else { return } // 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        // Plist로 유저 검사
        // let loginSuccess: Bool = userModel.findUser(name: username, pwd: password)
        let loginSuccess: Bool = findUser(name: username, password: password)
        if loginSuccess {
            
            // 01. UIAlertController의 인스턴스를 만든다.
            let alertController = UIAlertController(title: "로그인 성공", message: "로그인 성공하였습니다 ☺️", preferredStyle: .alert) // .actionSheet
            
            // 02. UIAlertController에 추가할 Action인 UIAlertAction을 만든다.
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (input: UIAlertAction) -> Void in
                let main = MainViewController()
                self.present(main, animated: true, completion: nil)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            // 03. UIAlertController에 UIAlertAction을 추가한다.
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // 04. UIAlertController를 self(뷰콘트롤러)에 최종적으로 추가한다.
            self.present(alertController, animated: true, completion: nil)
 
        }else {
            UIView.animate(withDuration: 0.1, animations: {
                self.usernameTextField.frame.origin.x -= 10
                self.passwordTextField.frame.origin.x -= 10
            }, completion: { _ in
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.usernameTextField.frame.origin.x += 20
                    self.passwordTextField.frame.origin.x += 20
                }, completion: { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        self.usernameTextField.frame.origin.x -= 10
                        self.passwordTextField.frame.origin.x -= 10
                    })
                })
            })
        }
    }

    @objc func didEndOnExit(_ sender: UITextField) {
        if usernameTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }else if passwordTextField.isFirstResponder {
            loginButton.becomeFirstResponder()
        }
    }
    
    func findUser(name: String, password: String) -> Bool {
        guard let userList: [[String:String]] = UserDefaults.standard.array(forKey: "UserList") as? [[String : String]] else { return false }
        UserDefaults.standard.object(forKey: "UserList")
        for userData in userList {
            let memberID: String = userData["ID"]!
            let memberPWD: String = userData["PWD"]!
            if name == memberID && password == memberPWD {
                return true
            }
        }
        return false
    }
    
    
}

//    /*****Segue, 할일을 하기 직전에 클로저를 담아서 보내줘 : prepare*****/
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // segue.destination은 UIViewController의 상속을 받은 Down캐스팅(형변환)이기 때문에 안전하게 옵셔널 체이닝
//        // segue.source 는 previous ViewController인 SignInViewController
//        if let nextViewController = segue.destination as? SignUpViewController {
//           // SignUpViewController의 didTaskClosure에 클로저를 만들어서 담아 보낸다.
//            nextViewController.didTaskClosure = {
//                (name: String, password: String) -> Void in return
//                self.userModel.addUser(name: name, pwd: password)
//            }
//        }
//    }
//}

