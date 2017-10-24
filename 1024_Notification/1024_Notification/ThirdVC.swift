//
//  ThirdVC.swift
//  FinalStackProject
//
//  Created by 김기윤 on 24/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ThirdVC: UIViewController {

    @IBOutlet weak var ThirdTF: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func notiPostBtn(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name.TestPush, object:ThirdTF!.text, userInfo: ["noti":"userInformation"])
    }

}

extension Notification.Name {
    static let TestPush:Notification.Name = Notification.Name("testNoti")
}

