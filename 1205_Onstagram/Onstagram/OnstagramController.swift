//
//  OSViewController.swift
//  Onstagram
//
//  Copyright © 2017년 yunari.me. All rights reserved.
//  UIViewController 추상화
//

import UIKit

enum TabItemControllerType {
    case Main
    case AddPost
    case Profile
}

class OnstagramController: UIViewController {

    var tabIndexType: TabItemControllerType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
