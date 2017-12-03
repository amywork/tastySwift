import UIKit
class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - deinit 할 떄 removeObserver
        NotificationCenter.default.addObserver(forName: Notification.Name.init("LogOut"), object: nil, queue: nil) { (noti) in
            self.showLoginGateVC()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // With LoginFlow Segue
        if DataCenter.main.currentUser == nil {
            performSegue(withIdentifier: "LoginFlow", sender: nil)
        }
    }
    
    func showLoginGateVC() {
        let loginSB = UIStoryboard(name: "LoginFlow", bundle: nil)
        if let gateVC = loginSB.instantiateViewController(withIdentifier: "SigningNavigationController") as? UINavigationController {
            self.present(gateVC, animated: false, completion: nil)
        }
    }
    
    // NotificationCenter에 등록된 Observer를 무조건 remove 해줘야 한다.
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

