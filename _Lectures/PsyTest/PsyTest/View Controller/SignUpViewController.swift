

import UIKit

class SignUpViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var rePasswordTextField: UITextField!
  
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(willChangedKeyboardFrame(notification:)),
      name: .UIKeyboardWillChangeFrame,
      object: nil
    )
    
  }
  
  
  // MARK: - Actions
  // Keyboard
  @objc func willChangedKeyboardFrame(notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
    let visibleHeight = UIScreen.main.bounds.height - keyboardFrame.origin.y
    
    scrollView.contentInset = UIEdgeInsetsMake(0, 0, visibleHeight, 0)
  }
  
  // SignUp
  @IBAction func didTapSignUpButton(_ sender: RoundButton) {
    
    
  }
  
  
  
  
}
