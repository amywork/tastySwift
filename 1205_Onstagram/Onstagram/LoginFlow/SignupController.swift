//
//  SignupVC.swift
//

import UIKit
import Firebase
import FirebaseAuth

class SignupController: UIViewController {

    // MARK: - UI Property
    let logoContainerView: UIView = {
        let view = UIView()
        let label = UILabel()
        view.addSubview(label)
        label.text = "Join Onstagram"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .center
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        return view
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    @objc func handleTextInputChange() {
        if let _ = emailTextField.text, let _ = passwordTextField.text {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = .blue
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .lightGray
        }
    }
    
    var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupLayout()
    }

}

extension SignupController {
    
    @objc func handleSignUp(_ sender: UIButton) {
        guard let id = emailTextField.text else { return }
        guard let pw = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: id, password: pw) { (user, error) in
            if error == nil {
                Auth.auth().signIn(withEmail: id, password: pw) { (user, error) in
                    if let user = user {
                        GlobalState.instance.uid = user.uid
                        GlobalState.instance.email = user.email
                        self.navigationController?.dismiss(animated: true, completion: nil)
                    }else if let error = error {
                        print("Failed to sign in: ", error)
                    }else {
                        print("Failed")
                    }
                }
            }else {
                print(error.debugDescription)
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,signUpButton])
        self.view.addSubview(stackView)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
    }
}
