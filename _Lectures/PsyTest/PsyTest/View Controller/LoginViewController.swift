
import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var usernameTextField: CustomTextField!
  @IBOutlet weak var passwordTextField: CustomTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    usernameTextField.leftView = UIImageView(image: #imageLiteral(resourceName: "profile"))
    usernameTextField.leftViewMode = .always
    
    usernameTextField.configureAttributedString(
      string: "아이디를 입력해주세요.",
      range: NSRange(location:0, length: 3),
      stringColor: UIColor.red.withAlphaComponent(0.5)
    )
    
    passwordTextField.leftView = UIImageView(image: #imageLiteral(resourceName: "key"))
    passwordTextField.leftViewMode = .always
    
    passwordTextField.configureAttributedString(
      string: "비밀번호를 입력해주세요.",
      range: NSRange(location:0, length: 4),
      stringColor: UIColor.red.withAlphaComponent(0.5)
    )
    
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow(notification:)),
      name: .UIKeyboardWillShow, object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide(notification:)),
      name: .UIKeyboardWillHide,
      object: nil
    )
    
  }
  
  @objc func keyboardWillShow(notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
    
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0)
  
  }
  
  @objc func keyboardWillHide(notification: Notification) {
//    guard let userInfo = notification.userInfo else { return }
//    guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
//
    scrollView.contentInset = UIEdgeInsets.zero
  }
  
  
  @IBAction func didTapSignInButton(_ sender: RoundButton) {
    guard let username = usernameTextField.text, !username.isEmpty else { return }
    guard let password = passwordTextField.text, !password.isEmpty else { return }
    
    if UserService.sharedInstance.validateUserInfo(username: username, password: password) {
      // 로그인이 성공
      print("성공")
      
    } else {
      // 로그인이 실패
      print("실패")
    }
    
  }
  
  
  
  
  
  
  
}
