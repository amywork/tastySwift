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

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Login Check : if false -> present LoginVC
        if !checkLogin() {
            DispatchQueue.main.async {
                let loginVC = UIStoryboard.main.makeLoginVC()
                let loginNavi = UINavigationController(rootViewController: loginVC)
                self.present(loginNavi, animated: true, completion: nil)
            }
        }
        self.delegate = self // UITabBarControllerDelegate
        setupViewControllers()
    }

    private func setupViewControllers() {
        // 01. "Main" tab
        let mainTab = MainController()
        mainTab.tabIndexType = .Main
        let mainNavi = templateNaviController(title: "home", unselectedImage: #imageLiteral(resourceName: "Feed_Off"), selectedImage: #imageLiteral(resourceName: "Feed_On"), rootViewController: mainTab)
        
        // 02. "AddPost" tab
        let addPostTab = OnstagramController()
        addPostTab.tabBarItem = UITabBarItem(title: "post", image: #imageLiteral(resourceName: "Camera_Off"), selectedImage: #imageLiteral(resourceName: "Camera_On"))
        addPostTab.tabIndexType = .AddPost
        
        // 03. "Profile" tab
        let profileTab = UserProfileController()
        profileTab.tabIndexType = .Profile
        let profileNavi = templateNaviController(title: "profile", unselectedImage: #imageLiteral(resourceName: "ProfileOff"), selectedImage: #imageLiteral(resourceName: "ProfileOn"), rootViewController: profileTab)
       
        tabBar.tintColor = .black
        self.viewControllers = [mainNavi, addPostTab, profileNavi]
    }

    // MARK: - should select viewController?
    // Present imagePickTab modally
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let type = (viewController as? OnstagramController)?.tabIndexType
        switch type {
        case .AddPost?:
            let imagePickTab = PhotoSelectorController()
            imagePickTab.pickerType = .NewPostPicker
            let navi = UINavigationController(rootViewController: imagePickTab)
            self.present(navi, animated: true, completion: nil)
            return false
        default:
            break
        }
        return true
    }
    
    // MARK: - checkLogin
    private func checkLogin() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        }else {
           return true
        }
    }

    fileprivate func templateNaviController(title: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.title = title
        return navController
    }
    
}
