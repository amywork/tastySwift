//
//  AppDelegate.swift
//  Graygram
//
//  Created by Suyeol Jeon on 31/05/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import Alamofire
import Kingfisher
import ManualLayout
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  class var instance: AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
  }

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()

    let viewController = SplashViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    window.rootViewController = navigationController

    self.window = window
    return true
  }

  func presentMainScreen() {
    let tabBarControlelr = MainTabBarController()
    self.window?.rootViewController = tabBarControlelr
  }

  func presentLoginScreen() {
    let viewController = LoginViewController()
    let navigationController = UINavigationController(rootViewController: viewController)
    self.window?.rootViewController = navigationController
  }
}



















