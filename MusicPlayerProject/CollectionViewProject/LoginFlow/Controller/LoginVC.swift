import UIKit
class LoginVC: UIViewController {
   
    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var scrollView: UIScrollView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutTextField()
    }
    
   @IBAction func didTapBackBtn(_sender: UIButton) {
    userNameTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
    }
    
    // MARK: didTapLoginButton
    @IBAction func didTapLoginButton(_sender: RoundButton) {
        guard let username = userNameTextField.text, !username.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        if DataCenter.main.validateUserInfo(username: username, password: password) {
            // 로그인 성공, didEnterBackground 할 때 write 할 것.
            let newUserDic = ["userID":username,"userPWD":password]
            DataCenter.main.currentUser = UserModel(userDic: newUserDic)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }else {
            // 로그인 실패 Alert
            let alertVC = UIAlertController(title: "로그인 실패", message: "아이디와 패스워드를 확인해주세요", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(okAction)
        }
    }
}

/*Extension: TextField */
extension LoginVC: UITextFieldDelegate {
    
    func layoutTextField() {
        // Default show keyboard
        userNameTextField.becomeFirstResponder()
        
        // UITextField is a UIControl, so you can target action
        userNameTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        
        // UITextField Placeholder Attributed String
        userNameTextField.configureAttributedString(
            string: "아이디를 입력해주세요",
            range: NSRange(location: 0, length: 11),
            stringColor: .lightGray
        )
        
        let placeHolderStr = NSAttributedString(string: "비밀번호를 입력해주세요", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray])
        passwordTextField.attributedPlaceholder = placeHolderStr
        
        // Notification Center: Keyboard가 올라왔을 때 화면의 스크롤뷰 UIEdge 조정
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    // MARK: UITextFieldDelegate delegate method
    // didEndOnExit: Find out when editing has ended, when TF resign being first respnder
    @objc func didEndOnExit(_ sender: UITextField) {
        if userNameTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
    }
    
}
