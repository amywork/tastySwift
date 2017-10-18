import UIKit
class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userNameTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    /*
    required init?(coder aDecoder: NSCoder) {
	    스토리보드가 인스턴스화 되는 시점
    }
 
    override func awakeFromNib() {
        스토리보드에 연결되는 @IBOutlet 들이 연결되는 시점
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.leftView = UIImageView(image: UIImage(named: "Heart"))
        userNameTextField.leftViewMode = .always
        passwordTextField.leftView = UIImageView(image: UIImage(named: "Heart"))
        passwordTextField.leftViewMode = .always
        
        userNameTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(didEndOnExit), for: UIControlEvents.editingDidEndOnExit)

        userNameTextField.configureAttributedString(
            string: "아이디를 입력해주세요",
            range: NSRange(location: 0, length: 10),
            stringColor: .lightGray
        )
        
        let placeHolderStr = NSAttributedString(string: "비밀번호를 입력해주세요", attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray])
        passwordTextField.attributedPlaceholder = placeHolderStr
        
        
        // NotificationCenter (default: singleton)
        // Keyboard가 올라왔을 때 화면의 스크롤뷰 UIEdge도 올려주기
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    // Notification 인스턴스에 키보드의 정보를 모두 담고 있다.
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }

    /*****Keyboard 내리기 Function*****/
    @objc func didEndOnExit(_ sender: UITextField) {
        if userNameTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
    }
    
    
    @IBAction func didTapLoginButton(_sender: RoundButton) {
        guard let username = userNameTextField.text, !username.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        if UserService.sharedInstance.validateUserInfo(username: username, password: password) {
            // 로그인 성공
            print("suc")
        }else {
            // 로그인 실패
            print("fail")
        }
    }
    
}
