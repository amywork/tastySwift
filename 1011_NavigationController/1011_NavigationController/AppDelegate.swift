//
//  AppDelegate.swift
//  1011_NavigationController
//
//  Created by 김기윤 on 11/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 스토리보드와의 연결을 끊어놨기 때문에, 현재 UIApplication과 AppDelegate만 있는 상태로, UIWindow부터 새로 만들어야 한다.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 01. instantiateInitialViewController() : initial로 설정된 뷰콘트롤러가 있을 경우 바로 인스턴스
        // let rootVC: ViewController = storyboard.instantiateInitialViewController() as! ViewController
        
        // 02. ViewController()의 인스턴스를 바로 만들어서 rootViewController로 설정할 수도 있다.
        let rootVC2 = ViewController()
        rootVC2.view.backgroundColor = .red
        
        // 03. main 스토리보드를 통해 ViewController의 인스턴스를 만든다.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC: UIViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let naviController = UINavigationController(rootViewController: rootVC)
        
        // 04. tabbar가 window의 root
        let tabbar = UITabBarController()
        tabbar.viewControllers = [rootVC2, naviController]
        
        // UINavigationController의 인스턴스를 만들 때 무조건 rootViewController 설정해야 한다.
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

