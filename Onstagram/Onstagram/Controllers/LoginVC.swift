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
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.8470588235, blue: 0.8352941176, alpha: 1)
        btn.addTarget(self, action: #selector(signUpBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - LifeCycle
    // Auto LogIn
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Auth.auth().addStateDidChangeListener() { auth, user in
            if let user = user {
                let uid = user.uid
                let email = user.email
                let newUser = UserModel(email!, uid)
                DataCenter.shared.currentUser = newUser
                DispatchQueue.main.async {
                    let mainNavi = UINavigationController()
                    let mainVC = MainVC()
                    mainNavi.addChildViewController(mainVC)
                    self.present(mainNavi, animated: true, completion: nil)
                }
            }
        }
    }
    
    // setupLayout
    override func viewDidLoad() {
        super.viewDidLoad()
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
            print(error.debugDescription)
            if error == nil {
                guard let user = user else { return }
                let uid = user.uid
                let email = user.email
                let newUser = UserModel(email!, uid)
                print(newUser)
                DataCenter.shared.currentUser = newUser
                DispatchQueue.main.async {
                    let mainNavi = UINavigationController()
                    let mainVC = MainVC()
                    mainNavi.addChildViewController(mainVC)
                    self.present(mainNavi, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func signUpBtnHandler(_ sender: UIButton) {
        let next = UIStoryboard.main().makeSignupVC()
        self.present(next, animated: true, completion: nil)
    }

}

extension UIStoryboard {
    
    static func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func makeSignupVC() -> SignupVC {
        return self.instantiateViewController(withIdentifier: "SignUpVC") as! SignupVC
    }
    
}
