import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var SignUpScrollView: UIScrollView!
    @IBOutlet weak var conformPwdTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var usernameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    
    // MARK: - SignUp Action
    @IBAction func didTapSignUpBtn(_ sender: UIButton) {
        guard let id = usernameTextField.text else { return }
        guard let pwd = passwordTextField.text  else { return }
        guard let email = emailTextField.text else { return }
        let newUserDic = ["userID":id,"userPWD":pwd,"email":email,"birthday":id]
        DataCenter.mainCenter.currentUser = UserModel(userDic: newUserDic)
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        conformPwdTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTextFieldUI()
    }
    
}

/*Extension: UITextFieldDelegate*/
extension SignUpVC: UITextFieldDelegate {
    
    func updateTextFieldUI() {
        usernameTextField.configureAttributedString(
            string: "아이디를 입력해주세요",
            range: NSRange(location: 0, length: 3),
            stringColor: UIColor.black.withAlphaComponent(0.5)
        )
        
        emailTextField.configureAttributedString(
            string: "Email을 입력해주세요",
            range: NSRange(location: 0, length: 5),
            stringColor: UIColor.black.withAlphaComponent(0.5)
        )
        
        passwordTextField.configureAttributedString(
            string: "비밀번호를 입력해주세요",
            range: NSRange(location: 0, length: 4),
            stringColor: UIColor.black.withAlphaComponent(0.5)
        )
        
        conformPwdTextField.configureAttributedString(
            string: "비밀번호를 확인해주세요",
            range: NSRange(location: 0, length: 4),
            stringColor: UIColor.black.withAlphaComponent(0.5)
        )
        
        // 화면 띄웠을 때 키보드가 바로 보이게 처리
        usernameTextField.becomeFirstResponder()
        usernameTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        conformPwdTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        emailTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        
        // NotificationCenter (default: singleton)
        // Keyboard가 올라왔을 때 화면의 스크롤뷰 UIEdge도 올려주기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // Notification 인스턴스에 담겨있는 키보드의 정보를 활용하기
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        SignUpScrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        SignUpScrollView.contentInset = UIEdgeInsets.zero
    }
    
    // MARK: - UITextFieldDelegate delegate method
    // didEndOnExit: Find out when editing has ended, when TF resign being first responder
    @objc func didEndOnExit(_ sender: UITextField) {
        if usernameTextField.isFirstResponder {
            emailTextField.becomeFirstResponder()
        }else if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }else if passwordTextField.isFirstResponder {
            conformPwdTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        conformPwdTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
}
