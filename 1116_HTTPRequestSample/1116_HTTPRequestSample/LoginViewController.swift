//
//  ViewController.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
 
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet var pwTF: UITextField!

    @IBAction func signupHandler(_ sender: UIButton) {
        
        if checkData() {
            let userID = "woozicodn92"
            let userPW = "wooZico9@2@$@"
            
            NetworkManger.shared.requestSingup(id: userID, pw: userPW, completion: { [unowned self] (isSucess, data, err) in
                if isSucess{
                    NetworkManger.shared.saveToken()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainVC = storyboard.instantiateViewController(withIdentifier: "MainNavi") as! UINavigationController
                    self.present(mainVC, animated: true, completion: nil)
                }else {
                    print("error")
                }
            })
            
        }
    }
    
    
    @IBAction func loginHandler(_ sender: UIButton) {
        
    }
    
    func checkData() -> Bool {
        //아이디와 비밀번호, 특수문자 등 검사
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if NetworkManger.shared.token != nil {
            print(NetworkManger.shared.token!)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "MainNavi") as! UINavigationController
            self.present(mainVC, animated: false, completion: nil)
        }
    }
    
}

