//
//  SignInViewController.swift
//  0927_SignUp
//  Created by 김기윤 on 27/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    var userModel: [[String: String]] = [
        ["username": "zico", "password": "1234"],
        ["username": "millic", "password": "5678"],
        ["username": "crush", "password": "9123"],
        ["username": "dean", "password": "4567"],
        ["username": "penomeco", "password": "8901"],
    ] // 딕셔너리를 담은 배열
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RoundButton! // RoundButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapLoginButton(_ sender: RoundButton) {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        for dict in userModel {
            if dict["username"] == username && dict["password"] == password {
                print("Success")
                return
            }
        }
        print("Failed")
        return
    }
    
    

}
