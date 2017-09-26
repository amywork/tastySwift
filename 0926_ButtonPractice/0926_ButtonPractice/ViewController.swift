//
//  ViewController.swift
//  0926_ButtonPractice
//
//  Created by 김기윤 on 26/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tile01: UIButton = UIButton()
    var tile02: UIButton = UIButton()
    var tile03: UIButton = UIButton()
    var tile04: UIButton = UIButton()
    var tile05: UIButton = UIButton()
    var tile06: UIButton = UIButton()
    var tile07: UIButton = UIButton()
    var tile08: UIButton = UIButton()
    var tile09: UIButton = UIButton()
    var logoLabel: UILabel = UILabel()
    var oddTileArr: [UIButton]?
    var evenTileArr: [UIButton]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK -- UIButton, UIControl Test
        tile01 = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile01)
        tile01.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        tile01.tag = 1
        
        tile02 = UIButton(frame: CGRect(x: view.frame.width/3, y: 0, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile02)
        tile02.backgroundColor = .white
        tile02.tag = 2
        
        tile03 = UIButton(frame: CGRect(x: view.frame.width - view.frame.width/3, y: 0, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile03)
        tile03.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        tile03.tag = 3

        tile01.addTarget(self, action: #selector(ViewController.chageEvenNumber(_:)), for: .touchUpInside)
        
        tile02.addTarget(self, action: #selector(ViewController.chageEvenNumber(_:)), for: .touchUpInside)
        
        tile03.addTarget(self, action: #selector(ViewController.chageEvenNumber(_:)), for: .touchUpInside)
        
        
        tile04 = UIButton(frame: CGRect(x: 0, y: view.frame.height/3, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile04)
        tile04.backgroundColor = .white
        tile04.tag = 4
        
        tile05 = UIButton(frame: CGRect(x: view.frame.width/3, y: view.frame.height/3, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile05)
        tile05.setTitle("🤗", for: .normal)
        tile05.titleLabel?.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight.heavy)
        tile05.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        tile05.tag = 5
        
        tile06 = UIButton(frame: CGRect(x: view.frame.width - view.frame.width/3, y: view.frame.height/3, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile06)
        tile06.backgroundColor = .white
        tile06.tag = 6
        
        
        tile04.addTarget(self, action: #selector(ViewController.changeOddNumber(_:)), for: .touchUpInside)
        
        tile05.addTarget(self, action: #selector(ViewController.changeOddNumber(_:)), for: .touchUpInside)
        
        tile06.addTarget(self, action: #selector(ViewController.changeOddNumber(_:)), for: .touchUpInside)
        
        
        tile07 = UIButton(frame: CGRect(x: 0, y: view.frame.height/3 * 2, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile07)
        tile07.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        tile07.tag = 7
        
        tile08 = UIButton(frame: CGRect(x: view.frame.width/3, y: view.frame.height/3 * 2, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile08)
        tile08.backgroundColor = .white
        tile08.tag = 8
        
        tile09 = UIButton(frame: CGRect(x: view.frame.width - view.frame.width/3, y: view.frame.height/3 * 2, width: view.frame.width/3, height: view.frame.height/3))
        self.view.addSubview(tile09)
        tile09.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        tile09.tag = 9
        
        tile07.addTarget(self, action: #selector(ViewController.changeLabel(_:)), for: .touchUpInside)
        
        tile08.addTarget(self, action: #selector(ViewController.changeLabel(_:)), for: .touchUpInside)
        
        tile09.addTarget(self, action: #selector(ViewController.changeLabel(_:)), for: .touchUpInside)
        
        logoLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height/3 * 2, width: self.view.frame.width, height: 100))
        view.addSubview(logoLabel)
        logoLabel.text = "TOKYO ❤️💙"
        logoLabel.textAlignment = .center
        logoLabel.textColor = UIColor.black
        logoLabel.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight.heavy)
        

        oddTileArr = [tile01, tile03, tile05, tile07, tile09]
        evenTileArr = [tile02, tile04, tile06, tile08]
        addMonoColorFunc()
        
    }
    
    
    //MARK ---------------
    
//    func addtoTileArr(with btn: UIButton) {
//        tileBtnArr?.append(btn)
//    }

    func addMonoColorFunc() {
        if oddTileArr != nil {
            for tile in oddTileArr! {
                tile.addTarget(self, action: #selector(ViewController.changeMonoColor(_:)), for: .touchUpInside)
            }
        }
    }
    
    var colorOnOff = ColorOnOff.on
    enum ColorOnOff {
        case on
        case off
    }
    
    @objc func changeMonoColor(_ sender: UIButton) {
        switch colorOnOff {
        case .on:
            sender.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            colorOnOff = .off
        case .off:
            sender.backgroundColor = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)
            colorOnOff = .on
        }
    }
    
    
    //MARK ---------------
    
    var labelOnOff = LabelOnOff.on
    enum LabelOnOff {
        case on
        case off
    }
    
    @objc func changeLabel(_ sender: UIButton) {
        switch labelOnOff {
        case .on:
            logoLabel.text = "LONDON 💜🖤"
            tile05.setTitle("😍", for: .normal)
            labelOnOff = .off
        case .off:
            logoLabel.text = "PARIS 💛💚"
            tile05.setTitle("😅", for: .normal)
            labelOnOff = .on
        }
    }

    
    //MARK ---------------
    
    var tileOnOff = OnOff.on
    enum OnOff {
        case on
        case off
    }
    
    @objc func changeOddNumber(_ sender: UIButton) {
        switch tileOnOff {
        case .on:
            for tile in oddTileArr! {
                tile.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
            tile05.setTitle("🙄", for: .normal)
            tileOnOff = .off
        case .off:
            for tile in oddTileArr! {
                tile.backgroundColor = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
            }
            tile05.setTitle("😔", for: .normal)
            tileOnOff = .on
        }
    }
    
    @objc func chageEvenNumber(_ sender: UIButton) {
        switch tileOnOff {
        case .on:
            for tile in evenTileArr! {
                tile.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            }
            tile05.setTitle("😗", for: .normal)
            tileOnOff = .off
        case .off:
            for tile in evenTileArr! {
                tile.backgroundColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
            }
            tile05.setTitle("😐", for: .normal)
            tileOnOff = .on
        }
    }
    
    
    
}

