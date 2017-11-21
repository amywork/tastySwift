//
//  MainTabVC.swift
//  Onstagram
//
//  Created by 김기윤 on 21/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MainTabVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin() // Login Check
        self.delegate = self // UITabBarControllerDelegate
        setupVCs() // Make 3Tabs
    }

    private func setupVCs() {
        let mainTab = MainVC()
        mainTab.tabBarItem = UITabBarItem(title: "explore", image: #imageLiteral(resourceName: "Feed_Off"), selectedImage: #imageLiteral(resourceName: "Feed_On"))
        let imagePickTab = UIViewController()
        imagePickTab.tabBarItem = UITabBarItem(title: "post", image: #imageLiteral(resourceName: "Camera_Off"), selectedImage: #imageLiteral(resourceName: "Camera_On"))
        let settingTab = SettingVC()
        settingTab.tabBarItem = UITabBarItem(title: "setting", image: #imageLiteral(resourceName: "Setting_Off"), selectedImage: #imageLiteral(resourceName: "Setting_On"))
        self.viewControllers = [mainTab, imagePickTab, settingTab]
    }

    // MARK: - imagePickTab present modally
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = self.viewControllers?.index(of: viewController)
        if index == 1 {
            let imagePickTab = ImagePickerVC(collectionViewLayout: UICollectionViewFlowLayout())
            let navi = UINavigationController(rootViewController: imagePickTab)
            self.present(navi, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    private func checkLogin() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = UIStoryboard.main.makeLoginVC()
                let loginNavi = UINavigationController(rootViewController: loginVC)
                self.present(loginNavi, animated: true, completion: nil)
            }
        }
    }

}
