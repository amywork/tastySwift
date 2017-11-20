//
//  SignupVC.swift
//  Onstagram
//
//  Created by Kyuhan Shin on 2017. 11. 20..
//  Copyright © 2017년 Kyuhan Shin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignupVC: UIViewController {

    // MARK: - UI Property
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.placeholder = "  id를 입력해주세요"
        tf.backgroundColor = .white
        return tf
    }()
    
    var pw1TextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.placeholder = "  password를 입력해주세요"
        tf.backgroundColor = .white
        return tf
    }()
    
    var pw2TextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.placeholder = "  password를 확인 해 주세요"
        tf.backgroundColor = .white
        return tf
    }()
    
    var doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign up", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.addTarget(self, action: #selector(doneBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

extension SignupVC {
    private func setupUI() {
        view.addSubview(doneBtn)
        doneBtn.frame = CGRect(x: 0, y: view.frame.size.height - 44, width: view.frame.size.width, height: 44)
        autoLayoutTFs()
    }
    
    @objc func doneBtnHandler(_ sender: UIButton) {
        guard let id = emailTextField.text, !id.isEmpty else {return}
        guard let pw1 = pw1TextField.text else {return}
        guard let pw2 = pw2TextField.text else {return}
        guard pw1 == pw2 else {
            let alert = UIAlertController(title: "패스워드 오류", message: "패스워드 일치 확인 해 주세요", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            alert.addTextField(configurationHandler: { (tf) in
                tf.placeholder = "password"
            })
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: id, password: pw1) { (user, error) in
            print(error.debugDescription)
            let mainVC = MainVC()
            self.present(mainVC, animated: true, completion: nil)
        }
        
    }
    
    private func autoLayoutTFs() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,pw1TextField,pw2TextField])
        self.view.addSubview(stackView)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: doneBtn.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: doneBtn.heightAnchor, multiplier: 3).isActive = true
        stackView.widthAnchor.constraint(equalTo: doneBtn.widthAnchor, multiplier: 1).isActive = true
    }
    
}
