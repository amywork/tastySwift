//
//  ViewController.swift
//  Onstagram
//
//  Created by Kyuhan Shin on 2017. 11. 20..
//  Copyright © 2017년 Kyuhan Shin. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
 
    // MARK: - UI Property
    var nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = DataCenter.shared.currentUser?.email
        lb.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        
       return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        nameLabel.safeAreaAutoLayout(self.view)
    }

    private func setUp() {
        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(nameLabel)
    }

}

extension UIView {
    
    public func safeAreaAutoLayout(_ superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
}
