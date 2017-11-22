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
        if !checkLogin() // Login Check
        {
            DispatchQueue.main.async {
                let loginVC = UIStoryboard.main.makeLoginVC()
                let loginNavi = UINavigationController(rootViewController: loginVC)
                self.present(loginNavi, animated: true, completion: nil)
            }
        }

        self.delegate = self // UITabBarControllerDelegate
        setupVCs() // Make 3Tabs
    }

    private func setupVCs() {
        let mainTab = MainVC()
        mainTab.tabBarItem = UITabBarItem(title: "explore", image: #imageLiteral(resourceName: "Feed_Off"), selectedImage: #imageLiteral(resourceName: "Feed_On"))
        mainTab.tabIndexNum = .Explore
        let imagePickTab = OSViewController()
        imagePickTab.tabBarItem = UITabBarItem(title: "post", image: #imageLiteral(resourceName: "Camera_Off"), selectedImage: #imageLiteral(resourceName: "Camera_On"))
        imagePickTab.tabIndexNum = .Post
        let settingTab = SettingVC()
        settingTab.tabBarItem = UITabBarItem(title: "setting", image: #imageLiteral(resourceName: "Setting_Off"), selectedImage: #imageLiteral(resourceName: "Setting_On"))
        self.viewControllers = [mainTab, imagePickTab, settingTab]
    }

    // MARK: - imagePickTab present modally
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let index = self.viewControllers?.index(of: viewController)
        let type = (viewController as! OSViewController).tabIndexNum
        //1 : 이미지픽커탭 index값
        if type == .Post {
            let imagePickTab = ImagePickerVC(collectionViewLayout: UICollectionViewFlowLayout())
            
            let navi = UINavigationController(rootViewController: imagePickTab)
            self.present(navi, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    private func checkLogin() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        }else
        {
           return true
        }
    }

}
