//
//  LoginVC.swift
//  Onstagram
//
//  Created by Kyuhan Shin on 2017. 11. 20..
//  Copyright © 2017년 Kyuhan Shin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController  {
  
    // MARK: - FirebaseAuth
    var handle: AuthStateDidChangeListenerHandle?
    
    // MARK: - UI Property
    var emailTextField: UITextField = {
        let tf = UITextField()
        
        tf.layer.borderWidth = 1
        tf.placeholder = "id를 입력해주세요"
        tf.text = "sk8w95@naver.com"
        return tf
    }()
   
    var pw1TextField: UITextField = {
        let tf = UITextField()
        
        tf.layer.borderWidth = 1
        tf.placeholder = "password를 입력해주세요"
        tf.text = "so57csd#@!"
        return tf
    }()
    
    var doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.addTarget(self, action: #selector(doneBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    var signUpBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Create an account", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        btn.addTarget(self, action: #selector(signUpBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // …
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
}

// MARK: - UI methods
extension LoginVC {
    private func setupUI() {
        view.addSubview(emailTextField)
        view.addSubview(pw1TextField)
        view.addSubview(doneBtn)
        view.addSubview(signUpBtn)
        emailTextField.frame = CGRect(x: 0, y: 30, width: view.frame.size.width, height: 44)
        pw1TextField.frame = CGRect(x: 0, y: 44+30, width: view.frame.size.width, height: 44)
        doneBtn.frame = CGRect(x: 0, y: view.frame.size.height - 44, width: view.frame.size.width, height: 44)
        
        signUpBtn.frame = CGRect(x: 0, y: view.frame.size.height - 88, width: view.frame.size.width, height: 44)
    }
    
    @objc func doneBtnHandler(_ sender: UIButton) {
        guard let id = emailTextField.text else {return}
        guard let pw = pw1TextField.text else {return}
        Auth.auth().signIn(withEmail: id, password: pw) { (user, error) in
            print(error.debugDescription)
            if let user = user{
                let uid = user.uid
                let email = user.email
                let newUser = UserModel(email!, uid)
                DataCenter.shared.currentUser = newUser
                let mainVC = MainVC()
                self.present(mainVC, animated: true, completion: nil)
            }
        }
    }
    
    @objc func signUpBtnHandler(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let next = sb.makeSignupVC()
        self.present(next, animated: true, completion: nil)
    }

}

extension UIStoryboard {
    
    func makeSignupVC() -> SignupVC {
        return self.instantiateViewController(withIdentifier: "SignUpVC") as! SignupVC
    }
    
}