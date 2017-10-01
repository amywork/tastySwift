//
//  ViewController.swift
//  1001_UITestStanford
//
//  Created by Kimkeeyun on 01/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var titleLabel: UILabel?
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x: 16, y: 100, width: view.bounds.size.width, height: 100)
        titleLabel?.text = "Face Kit"
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        view.addSubview(titleLabel!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

