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


class OSViewController: UIViewController {

    var tabIndexNum:TabItemControllerType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
