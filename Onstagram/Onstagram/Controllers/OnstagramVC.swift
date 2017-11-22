//
//  OSViewController.swift
//  Onstagram
//
//  Created by ilhan won on 2017. 11. 22..
//  Copyright © 2017년 yunari.me. All rights reserved.
//

import UIKit

enum TabItemControllerType {
    case Explore
    case Post
    case Setting
}

class OnstagramVC: UIViewController {

    var tabIndexType: TabItemControllerType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
