//
//  SignUpViewController.swift
//  0927_SignUp
//
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    /*****Outlet*****/
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var conformPwd: UITextField!
    
    /*****Action*****/
    @IBAction func signUpBtn(_ sender: UIButton) {
        guard let username = username.text else { return }
        guard let password = password.text else { return }
        guard let conformPwd = conformPwd.text else { return }
        if password == conformPwd {
            print(username, password, conformPwd)
        }
        
    }
    
    @IBAction func didTapExitButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*****ViewDidLoad*****/
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
