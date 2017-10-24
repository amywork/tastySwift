//
//  SecondVC.swift
//  FinalStackProject
//
//  Created by 김기윤 on 24/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var secondLB: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name.init("TestNoti"), object: nil, queue: nil) { (noti) in
            if let text = noti.object as? String {
                self.secondLB.text = text
            }
        }
    }


}
