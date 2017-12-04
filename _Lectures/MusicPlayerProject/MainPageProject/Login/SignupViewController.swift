
import UIKit

class SignupViewController: UIViewController {
  
  // Properties
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var rePasswordTextField: UITextField!
  
  var didTaskClosure: ((String, String) -> Void)? = nil
  
  // View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
    passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
    rePasswordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
  }
  
  // Actions
  @objc func didEndOnExit(_ sender: UITextField) {
    
    if sender === nameTextField {
      passwordTextField.becomeFirstResponder()
    } else if sender === passwordTextField {
      rePasswordTextField.becomeFirstResponder()
    }

  }
  
  
  @IBAction func didTapSignUpButton(_ sender: UIButton) {
    guard let username = nameTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    guard let rePassword = rePasswordTextField.text else { return }
    
    // 입력받은 패스워드 두개의 문자열이 같은지 비교!
    if password == rePassword {
      // 같다면 회원가입 성공
      didTaskClosure?(username, password)
      dismiss(animated: true, completion: nil)
      
    } else {
      // 다르다면 회원가입 실패
      print("로그인 실패")
    }
    
 
  }
  
  
  
  
  
  @IBAction func didTapExitButton(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}

