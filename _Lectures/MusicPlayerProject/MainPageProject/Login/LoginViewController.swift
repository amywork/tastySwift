
import UIKit

class LoginViewController: UIViewController {
  
  var userModel = UserModel()
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: RoundButton!
  

  override func viewDidLoad() {
    super.viewDidLoad()

    usernameTextField.addTarget(self, action: #selector(didEndOnExit), for: .editingDidEndOnExit)
    
    passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: .editingDidEndOnExit)

    usernameTextField.layer.cornerRadius = 10
    usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
    usernameTextField.layer.borderWidth = 1 / UIScreen.main.scale
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if let nextViewController = segue.destination as? SignupViewController {
      nextViewController.didTaskClosure = { (name: String, password: String) -> Void in
        
        self.userModel.addUser(name: name, password: password)
      }
    }
  }
  
  @objc func didEndOnExit(_ sender: UITextField) {
    
    if sender === usernameTextField {
      passwordTextField.becomeFirstResponder()
    }
    
  }
  
  @IBAction func didTapLoginButton(_ sender: RoundButton) {
    
    UserDefaults.standard.set(true, forKey: "isLogined")
    self.navigationController?.dismiss(animated: true, completion: nil)
    
    
    guard let username = usernameTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    
    let isLoginSuccess: Bool = userModel.findUser(name: username, password: password)
    
    if isLoginSuccess {
      print("로그인 성공!!")
      // 화면 전환
      
      let main = MainViewController()
      present(main, animated: true, completion: nil)
      
    } else {
      
      usernameTextField.backgroundColor = UIColor.red.withAlphaComponent(0.5)
      passwordTextField.backgroundColor = UIColor.red.withAlphaComponent(0.5)
    }
    
    
  }
  
  
  
  
  
  
  
  
  
  
  
 
  
  
  
  
  
  
  
}

