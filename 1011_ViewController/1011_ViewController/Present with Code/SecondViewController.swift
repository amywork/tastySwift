//
//  SecondViewController.swift
//  1011_ViewController
//
//  Created by 김기윤 on 10/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let closeBtn = UIButton(type: .system)
        closeBtn.frame = CGRect(x: view.bounds.size.width-32, y: 30, width: 16, height: 16)
        closeBtn.backgroundColor = .blue
        
        view.addSubview(closeBtn)
        closeBtn.addTarget(self, action: #selector(self.close(_:)), for: .touchUpInside)
    }


    @objc func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
