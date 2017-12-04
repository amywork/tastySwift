//
//  MainNavi.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 20..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class MainNavi: UINavigationController {

//    private var isFirstLogin:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: Notification.Name.init("logoutNoti"), object: nil, queue: nil) { (noti) in
            self.showLoginPage()
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.bool(forKey: "isLogined")
        {
//            showLoginPage()
            performSegue(withIdentifier: "GoToLoginSegue", sender: nil)
//            isFirstLogin = false
        }
    }
    
    
    func showLoginPage()
    {
        performSegue(withIdentifier: "GoToLoginSegue", sender: nil)
        
//        let nextStoryboard = UIStoryboard(name: "LoginFlowStoryboard", bundle: nil)
//        if let presentVC = nextStoryboard.instantiateViewController(withIdentifier: "LoginNavi") as? UINavigationController
//        {
//            self.present(presentVC, animated: false, completion: nil)
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
