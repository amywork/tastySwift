//
//  LoginVC.swift
//  

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController  {
    
    // MARK: - UI Property
    var emailTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.8470588235, blue: 0.8352941176, alpha: 1)
        tf.placeholder = "  ID를 입력해주세요"
        tf.text = "sk8w95@naver.com"
        return tf
    }()
   
    var pw1TextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.8470588235, blue: 0.8352941176, alpha: 1)
        tf.placeholder = "  password를 입력해주세요"
        tf.text = "so57csd#@!"
        return tf
    }()
    
    var doneBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.8470588235, blue: 0.8352941176, alpha: 1)
        btn.addTarget(self, action: #selector(doneBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    var signUpBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.8470588235, blue: 0.8352941176, alpha: 1)
        btn.addTarget(self, action: #selector(signUpBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    // setupLayout
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupLayout()
    }
    
}

// MARK: - UI methods
extension LoginVC : UITextFieldDelegate {

    private func setupLayout() {
        let btnStackView = UIStackView(arrangedSubviews: [signUpBtn,doneBtn])
        btnStackView.alignment = .fill
        btnStackView.distribution = .fillEqually
        btnStackView.axis = .horizontal
        let stackView = UIStackView(arrangedSubviews: [emailTextField,pw1TextField,btnStackView])
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
    
    @objc func doneBtnHandler(_ sender: UIButton) {
        guard let id = emailTextField.text, let pw = pw1TextField.text else {
            let alert = UIAlertController(title: "로그인 실패",
                                          message: "아이디 혹은 패스워드를 확인해주세요",
                                          preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().signIn(withEmail: id, password: pw) { (user, error) in
            if error == nil {
                DispatchQueue.main.async {
                   self.navigationController?.dismiss(animated: true, completion: nil)
                }
            }else {
                print(error.debugDescription)
            }
        }
    }
    
    @objc func signUpBtnHandler(_ sender: UIButton) {
        let signupVC = UIStoryboard.main.makeSignupVC()
        signupVC.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(signupVC, animated: true)
    }

}

