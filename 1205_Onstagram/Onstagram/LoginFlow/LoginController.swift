//
//  LoginVC.swift
//  

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController  {
    
    // MARK: - UI Property
    let logoContainerView: UIView = {
        let view = UIView()
        let label = UILabel()
        view.addSubview(label)
        label.text = "Onstagram"
        label.font = UIFont.boldSystemFont(ofSize: 36)
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
            loginButton.isEnabled = true
            loginButton.backgroundColor = .blue
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightGray
        }
    }
    
    var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signin", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signup", for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    // setupLayout
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupLayout()
    }
    
}

// MARK: - UI methods
extension LoginController {

    @objc func handleLogin(_ sender: UIButton) {
        let id = emailTextField.text!
        let pw = passwordTextField.text!
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
    }
    
    @objc func handleSignup(_ sender: UIButton) {
        let signupVC = UIStoryboard.main.makeSignupVC()
        signupVC.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(signupVC, animated: true)
    }

    private func setupLayout() {
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        let btnStackView = UIStackView(arrangedSubviews: [signupButton,loginButton])
        btnStackView.alignment = .fill
        btnStackView.distribution = .fillEqually
        btnStackView.spacing = 4
        btnStackView.axis = .horizontal
        let stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,btnStackView])
        self.view.addSubview(stackView)
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
    }
    
}

