//
//  ViewController.swift
//  0926_ButtonPractice
//
//  Created by 김기윤 on 26/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var btnArr: [UIButton] = []
    var logoLabel: UILabel?
    
    func makeBtn() {
        for index: Int in 0..<9 {
            let btn = UIButton()
            btn.tag = index
            self.view.addSubview(btn)
            btn.backgroundColor =  #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
            btn.layer.borderColor = UIColor.black.cgColor // borderColor = CGcolor
            btn.layer.borderWidth = 1
            btnArr.append(btn)
        }
    }
    
    func makeBtnLayout(btnArr: [UIButton]) {
        for btn in btnArr {
            let index = btn.tag
            let row = index / 3 // 0, 0, 0, 1, 1, 1, 2, 2, 2
            let column = index % 3 // 0, 1, 2, 0, 1, 2, 0, 1, 2
            
            let width = self.view.frame.size.width/3
            let height = self.view.frame.size.height/3
            btn.frame = CGRect(x: CGFloat(column)*width, y: CGFloat(row)*height, width: width, height: height)
            btn.addTarget(self, action: #selector(ViewController.onClickBtn), for: .touchUpInside)
        }
    }
    

    var tileCase = OnOff.on
    enum OnOff {
        case on
        case off
    }
    
    func changeColorA(_ sender: UIButton) {
        let tag = sender.tag
        if isEvenNumber(num: tag) {
            sender.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else {
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.8193424344, blue: 0, alpha: 1)
        }
    }
    
    func changeColorB(_ sender: UIButton) {
        let tag = sender.tag
        if isEvenNumber(num: tag) {
            sender.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }else {
            sender.backgroundColor = #colorLiteral(red: 0.9818221927, green: 0.1470750272, blue: 1, alpha: 1)
        }
    }
    
    @objc func onClickBtn(_ sender: UIButton) {
        let index = sender.tag
        let isEvenNum: Bool = isEvenNumber(num: index)
        
        for btn in btnArr {
            let subBtnisEven =  isEvenNumber(num: btn.tag)
            if isEvenNum == subBtnisEven && !btn.isSelected
            {
                btn.backgroundColor = .yellow
                btn.isSelected = true
            }else if  isEvenNum == subBtnisEven && btn.isSelected
            {
                btn.backgroundColor = .blue
                btn.isSelected = false
            }
        }
    }


    @objc func switchColor(_ sender: UIButton) {
        for btn in btnArr {
            switch tileCase {
            case .on:
                changeColorA(btn)
                tileCase = .off
            case .off:
                changeColorB(btn)
                tileCase = .on
            }
        }
    }
    
    func isEvenNumber(num: Int) -> Bool {
        if num%2 == 0 {
            return true
        }else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBtn()
        makeBtnLayout(btnArr: btnArr)
    }

}


    



//    var colorOnOff = ColorOnOff.on
//    enum ColorOnOff {
//        case on
//        case off
//    }
//
//    @objc func changeMonoColor(_ sender: UIButton) {
//        switch colorOnOff {
//        case .on:
//            sender.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
//            colorOnOff = .off
//        case .off:
//            sender.backgroundColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)
//            colorOnOff = .on
//        }
//    }
//
//
//    //MARK ---------------
//
//    var labelOnOff = LabelOnOff.on
//    enum LabelOnOff {
//        case on
//        case off
//    }
//
//    @objc func changeLabel(_ sender: UIButton) {
//        switch labelOnOff {
//        case .on:
//            logoLabel.text = "LONDON 💜🖤"
//            tile05.setTitle("😍", for: .normal)
//            labelOnOff = .off
//        case .off:
//            logoLabel.text = "PARIS 💛💚"
//            tile05.setTitle("😅", for: .normal)
//            labelOnOff = .on
//        }
//    }
//
//
//    //MARK ---------------
//
//    var tileOnOff = OnOff.on
//    enum OnOff {
//        case on
//        case off
//    }
//
//    @objc func changeOddNumber(_ sender: UIButton) {
//        switch tileOnOff {
//        case .on:
//            for tile in oddTileArr! {
//                tile.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
//            }
//            tile05.setTitle("🙄", for: .normal)
//            tileOnOff = .off
//        case .off:
//            for tile in oddTileArr! {
//                tile.backgroundColor = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
//            }
//            tile05.setTitle("😔", for: .normal)
//            tileOnOff = .on
//        }
//    }
//
//    @objc func chageEvenNumber(_ sender: UIButton) {
//        switch tileOnOff {
//        case .on:
//            for tile in evenTileArr! {
//                tile.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
//            }
//            tile05.setTitle("😗", for: .normal)
//            tileOnOff = .off
//        case .off:
//            for tile in evenTileArr! {
//                tile.backgroundColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
//            }
//            tile05.setTitle("😐", for: .normal)
//            tileOnOff = .on
//        }
//    }
//
//

