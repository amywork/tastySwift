//
//  MainTabBarController.swift
//  FinalStackProject
//
//  Created by Kimkeeyun on 21/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // With LoginFlow Segue
        if DataCenter.mainCenter.currentUser == nil {
            performSegue(withIdentifier: "LoginFlow", sender: nil)
        }
    }
    
    func showLoginGateVC() {
        let loginSB = UIStoryboard(name: "LoginFlow", bundle: nil)
        if let gateVC = loginSB.instantiateViewController(withIdentifier: "SigningNavigationController") as? UINavigationController {
            self.present(gateVC, animated: false, completion: nil)
        }
    }
    
}
