import UIKit

final class LoginViewController: UIViewController {
  // 1. 속성 정의
  //   usernameTextField
  //   passwordTextField
  //   loginButton
  // 2. viewDidLoad에서 addSubview
  // 3. SnapKit을 사용해서 오른쪽 화면처럼 레이아웃 ---->
  // (backgroundColor를 임의로 지정해서 확인하기)

  fileprivate let usernameTextField = UITextField()
  fileprivate let passwordTextField = UITextField()
  fileprivate let loginButton = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(usernameTextField)
    self.view.addSubview(passwordTextField)
    self.view.addSubview(loginButton)

    usernameTextField.borderStyle = .roundedRect
    usernameTextField.placeholder = "Username"
    usernameTextField.autocorrectionType = .no
    usernameTextField.autocapitalizationType = .none
    usernameTextField.addTarget(
      self,
      action: #selector(textFieldDidChangeText),
      for: .editingChanged
    )

    passwordTextField.borderStyle = .roundedRect
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
    passwordTextField.addTarget(
      self,
      action: #selector(textFieldDidChangeText),
      for: .editingChanged
    )

    loginButton.setTitle("Login", for: .normal)
    loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    loginButton.backgroundColor = loginButton.tintColor
    loginButton.layer.cornerRadius = 5
    loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)

    usernameTextField.snp.makeConstraints { make in
      make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(30)
      make.left.equalTo(30)
      make.right.equalTo(-30)
      make.height.equalTo(30)
    }

    passwordTextField.snp.makeConstraints { make in
      make.top.equalTo(usernameTextField.snp.bottom).offset(10)
      make.left.equalTo(usernameTextField)
      make.right.equalTo(usernameTextField)
      make.height.equalTo(usernameTextField)
    }

    loginButton.snp.makeConstraints { make in
      make.top.equalTo(passwordTextField.snp.bottom).offset(10)
      make.left.right.height.equalTo(passwordTextField)
    }
  }

  func loginButtonDidTap() {
    guard let username = usernameTextField.text, !username.isEmpty else { return }
    guard let password = passwordTextField.text, !password.isEmpty else { return }
    login(username: username, password: password)
  }

  func login(username: String, password: String) {
    usernameTextField.isEnabled = false
    usernameTextField.alpha = 0.4
    passwordTextField.isEnabled = false
    passwordTextField.alpha = 0.4
    loginButton.isEnabled = false
    loginButton.alpha = 0.4

    AuthService.login(username: username, password: password) { response in
      self.usernameTextField.isEnabled = true
      self.usernameTextField.alpha = 1
      self.passwordTextField.isEnabled = true
      self.passwordTextField.alpha = 1
      self.loginButton.isEnabled = true
      self.loginButton.alpha = 1

      switch response.result {
      case .success(let value):
        print("로그인 성공! \(value)")
        AppDelegate.instance?.presentMainScreen()

      case .failure(let error):
        print("로그인 실패 😂 \(error)")
        if let errorInfo = response.errorInfo() {
          switch errorInfo.field {
          case "username":
            self.usernameTextField.becomeFirstResponder()
            self.usernameTextField.backgroundColor = UIColor.red.withAlphaComponent(0.5)
          case "password":
            self.passwordTextField.becomeFirstResponder()
            self.passwordTextField.backgroundColor = UIColor.red.withAlphaComponent(0.5)
          default:
            break
          }
        }
      }
    }
  }

  func textFieldDidChangeText(_ textField: UITextField) {
    UIView.animate(withDuration: 1) {
      textField.backgroundColor = .white
    }
  }
}


















