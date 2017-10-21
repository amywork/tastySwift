import UIKit

class SingUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conformPwdTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var usernameTextField: CustomTextField!
    @IBOutlet weak var SignUpScrollView: UIScrollView!
    @IBOutlet weak var emailTextField: CustomTextField!
    
    
    @IBAction func didTapSignUpBtn(_ sender: UIButton) {
        guard let id = usernameTextField.text else { return }
        guard let pwd = passwordTextField.text  else { return }
        let newUserDic = ["userID":id,"userPWD":pwd]
        DataCenter.mainCenter.currentUser = UserModel(userDic: newUserDic)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        conformPwdTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        emailTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        
        usernameTextField.configureAttributedString(
            string: "아이디를 입력해주세요",
            range: NSRange(location: 0, length: 3),
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
        
        
        emailTextField.configureAttributedString(
            string: "Email을 입력해주세요",
            range: NSRange(location: 0, length: 5),
            stringColor: UIColor.black.withAlphaComponent(0.5)
        )
        
        // NotificationCenter (default: singleton)
        // Keyboard가 올라왔을 때 화면의 스크롤뷰 UIEdge도 올려주기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

    }
    
    // Notification 인스턴스에 키보드의 정보를 모두 담고 있다.
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        SignUpScrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        SignUpScrollView.contentInset = UIEdgeInsets.zero
    }
    
    
    /*****Keyboard 내리기 Function*****/
    @objc func didEndOnExit(_ sender: UITextField) {
        if usernameTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }else if passwordTextField.isFirstResponder {
            conformPwdTextField.becomeFirstResponder()
        }else if conformPwdTextField.isFirstResponder {
            emailTextField.becomeFirstResponder()
        }
    }
    
    
}
