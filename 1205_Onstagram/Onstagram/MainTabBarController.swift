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
    
    // MARK: - checkLogin
    private func checkLogin() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        }else {
            return true
        }
    }

    private func setupViewControllers() {
        // Tab 01
        let myHomeTab = MyHomeController()
        myHomeTab.tabIndexType = .MyHome
        let myHomeNavi = templateNaviController(title: "My Home", unselectedImage: #imageLiteral(resourceName: "Feed_Off"), selectedImage: #imageLiteral(resourceName: "Feed_On"), rootViewController: myHomeTab)
        myHomeTab.navigationItem.title = "Onstagram"
        
        // Tab 02
        let addPostTab = OnstagramController()
        addPostTab.tabBarItem = UITabBarItem(title: "New Post", image: #imageLiteral(resourceName: "Camera_Off"), selectedImage: #imageLiteral(resourceName: "Camera_On"))
        addPostTab.tabIndexType = .AddPost
        
        tabBar.tintColor = .black
        self.viewControllers = [myHomeNavi,addPostTab]
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

    fileprivate func templateNaviController(title: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.title = title
        return navController
    }
    
}
