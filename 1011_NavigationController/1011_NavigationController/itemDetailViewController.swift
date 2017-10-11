//
//  itemDetailViewController.swift
//  1011_NavigationController
//
//  Created by 김기윤 on 11/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class itemDetailViewController: UIViewController {

    var labelStr: String?
    @IBOutlet weak var itemLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLabel.text = labelStr
    }

}
