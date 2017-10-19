//
//  itemDetailViewController.swift
//  1011_NavigationController
//
//  Created by 김기윤 on 11/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SecondViewController : UIViewController {

    var labelStr: String?
    var titleBtn: UIButton?
    var able: Bool = true
    
    @IBOutlet weak var itemLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLabel.text = labelStr
        self.navigationItem.title = "itemDetail"
        
        
        let popBtn = UIButton()
        popBtn.setTitle("✖︎", for: .normal)
        popBtn.setTitleColor(.black, for: .normal)
        popBtn.setTitleColor(.blue, for: UIControlState.highlighted)
        popBtn.addTarget(self, action: #selector(popBtnHandler), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: popBtn)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: nil)

        let homeBtn = UIButton()
        homeBtn.setTitle("Back", for: .normal)
        homeBtn.addTarget(self, action: #selector(popBtnHandler), for: .touchUpInside)
        homeBtn.setTitleColor(.black, for: .normal)
        homeBtn.setTitleColor(.white, for: .highlighted)
//        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: iconImage),UIBarButtonItem(customView: homeBtn)]
        
        
        titleBtn = UIButton()
        titleBtn!.setTitle("Click Me", for: .normal)
        titleBtn!.setTitleColor(.black, for: .normal)
        titleBtn!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        titleBtn!.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        self.navigationItem.titleView = titleBtn
        
    }
    
    @objc func changeColor() {
        if able {
            self.view.backgroundColor = #colorLiteral(red: 1, green: 0.5006016493, blue: 0.6636574864, alpha: 1)
            able = false
        }else {
            self.view.backgroundColor = .black
            able = true
        }
    }
    
    @objc func popBtnHandler() {
        popSecondViewController()
    }
    
    private func popSecondViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
