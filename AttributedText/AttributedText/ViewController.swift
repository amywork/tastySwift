//
//  ViewController.swift
//  AttributedText
//
//  Created by Kimkeeyun on 08/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
 
    func updateUI() {
        
        let text = "Hello World"

        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.underlineStyle: 1,
            NSAttributedStringKey.strokeWidth: 2,
            NSAttributedStringKey.kern: 4
            ] as [NSAttributedStringKey : Any]

        let attStr = NSAttributedString(string: text, attributes: attributes)
        label.attributedText = attStr
        label.font = UIFont.systemFont(ofSize: 20)
    }

}

