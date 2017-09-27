//
//  SignInViewController.swift
//  0927_SignUp
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SignInViewController: UIViewController {

    /*****Property*****/
    var userModel = UserModel() // Model의 인스턴스 생성
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundButton!
    
    func designTextField(_ textField: UITextField) {
        textField.layer.cornerRadius = 3
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1/UIScreen.main.scale
    }
    
    /*****viewDidLoad*****/
    override func viewDidLoad() {
        super.viewDidLoad()
        // TextField 의 디자인 입히기
        designTextField(usernameTextField)
        designTextField(passwordTextField)
        
        // Keyboard 내리기
        // addTarget은 UIResponder를 상속받은 클래스에게 모두 있다.
        usernameTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        loginButton.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
    }

    /*****SignIn 버튼을 눌렀을 때의 Action*****/
    @IBAction func didTapLoginButton(_ sender: RoundButton) {
        // 옵셔널 바인딩 & 예외 처리 : Textfield가 빈문자열이 아니고, nil이 아닐 때
        guard let username = usernameTextField.text, !username.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        // Model이 해당 유저를 가지고 있는지 검사
        let loginSuccess: Bool = userModel.hasUser(name: username, pwd: password)
        if loginSuccess {
            print("로그인 성공")
            let main = MainViewController() // MainViewController() : main으로 넘어가기
            self.present(main, animated: true, completion: nil)
        }else {
            UIView.animate(withDuration: 0.2, animations: {
                self.usernameTextField.frame.origin.x -= 10
                self.passwordTextField.frame.origin.x -= 10
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, animations: {
                    self.usernameTextField.frame.origin.x += 20
                    self.passwordTextField.frame.origin.x += 20
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, animations: {
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
        }
    }
    
    
    /*****Segue, 할일을 하기 직전에 클로저를 담아서 보내줘 : prepare*****/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segue.destination은 UIViewController의 상속을 받은 Down캐스팅(형변환)이기 때문에 안전하게 옵셔널 체이닝
        // segue.source 는 previous ViewController인 SignInViewController
        if let nextViewController = segue.destination as? SignUpViewController {
           // SignUpViewController의 didTaskClosure에 클로저를 만들어서 담아 보낸다.
            nextViewController.didTaskClosure = {
                (name: String, password: String) -> Void in return
                self.userModel.addUser(name: name, pwd: password)
            }
        }
    }
 
    
}
