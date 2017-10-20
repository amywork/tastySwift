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
        if DataCenter.mainCenter.currentUser == nil {
            performSegue(withIdentifier: "ToSigningNav", sender: self)
        }
    }
    
    /*
     override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
     if identifier == "ToSigningNav" {
     if DataCenter.mainCenter.currentUser == nil {
     return true
     }
     }
     return false
     }
     */
}
