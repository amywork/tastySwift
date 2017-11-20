//
//  SignupVC.swift
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
        tf.backgroundColor = #colorLiteral(red: 0.7510083914, green: 0.8462013602, blue: 0.8357997537, alpha: 1)
        return tf
    }()
    
    var pw1TextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.placeholder = "  password를 입력해주세요"
        tf.backgroundColor = #colorLiteral(red: 0.7510083914, green: 0.8462013602, blue: 0.8357997537, alpha: 1)
        return tf
    }()
    
    var pw2TextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.placeholder = "  password를 확인 해 주세요"
        tf.backgroundColor = #colorLiteral(red: 0.7510083914, green: 0.8462013602, blue: 0.8357997537, alpha: 1)
        return tf
    }()
    
    var doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign up", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(doneBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

}

extension SignupVC {
    
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
            if error == nil {
                Auth.auth().signIn(withEmail: id, password: pw1) { (user, error) in
                    print(error.debugDescription)
                    if error == nil {
                        guard let user = user else { return }
                        let uid = user.uid
                        let email = user.email
                        let newUser = UserModel(email!, uid)
                        print(newUser)
                        DataCenter.shared.currentUser = newUser
                        DispatchQueue.main.async {
                            let mainVC = MainVC()
                            self.present(mainVC, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField,pw1TextField,pw2TextField,doneBtn])
        self.view.addSubview(stackView)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 56).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
}
