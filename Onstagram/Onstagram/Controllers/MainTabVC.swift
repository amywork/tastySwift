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
        // Login Check
        // if false -> present LoginVC
        if !checkLogin()
        {
            DispatchQueue.main.async {
                let loginVC = UIStoryboard.main.makeLoginVC()
                let loginNavi = UINavigationController(rootViewController: loginVC)
                self.present(loginNavi, animated: true, completion: nil)
            }
        }

        self.delegate = self // UITabBarControllerDelegate
        setupVCs() // setup 3Tabs
    }

    private func setupVCs() {
        // 01. "Explore" tab
        let mainTab = ExploreVC()
        mainTab.tabBarItem = UITabBarItem(title: "explore", image: #imageLiteral(resourceName: "Feed_Off"), selectedImage: #imageLiteral(resourceName: "Feed_On"))
        mainTab.tabIndexType = .Explore
        
        // 02. "Post" tab
        let imagePickTab = OnstagramVC()
        imagePickTab.tabBarItem = UITabBarItem(title: "post", image: #imageLiteral(resourceName: "Camera_Off"), selectedImage: #imageLiteral(resourceName: "Camera_On"))
        imagePickTab.tabIndexType = .Post
        
        // 03. "Setting" tab
        let settingTab = SettingVC()
        settingTab.tabBarItem = UITabBarItem(title: "setting", image: #imageLiteral(resourceName: "Setting_Off"), selectedImage: #imageLiteral(resourceName: "Setting_On"))
        settingTab.tabIndexType = .Setting
        
        self.viewControllers = [mainTab, imagePickTab, settingTab]
    }

    // MARK: - should select view controller?
    // Present imagePickTab modally
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let type = (viewController as! OnstagramVC).tabIndexType
        switch type {
        case .Post?:
            let imagePickTab = ImagePickerVC(collectionViewLayout: UICollectionViewFlowLayout())
            let navi = UINavigationController(rootViewController: imagePickTab)
            self.present(navi, animated: true, completion: nil)
            return false
        default:
            break
        }
        return true
    }
    
    // MARK: - imagePickTab present modally
    private func checkLogin() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        }else {
           return true
        }
    }

}
