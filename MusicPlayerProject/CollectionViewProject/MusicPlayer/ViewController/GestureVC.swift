//
//  GestureVC.swift
//  CollectionViewProject
//
//  Created by 김기윤 on 30/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class GestureVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var topLabel:UILabel!
    @IBOutlet var secondLabel:UILabel!
    var count:String = ""
    var location:String = ""
    
    @IBAction func tapGesture(_ sender: UITouch) {
        //topLabel.text = count
        //secondLabel.text = location
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        count = "🙃 Tap Count : \(touch.tapCount) "
        location = "🙃 X 좌표: \(touch.location(in: self.view).x) " + "🙃 Y 좌표: \(touch.location(in: self.view).y)"
        topLabel.text = count
        secondLabel.text = location
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
