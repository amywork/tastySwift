//
//  ViewController.swift
//  0925_BallGame
//
//  Created by Kimkeeyun on 24/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    //Mark - 01. UILabel
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var displayLabel01: UILabel!
    @IBOutlet weak var displayLabel02: UILabel!
    @IBOutlet weak var displayLabel03: UILabel!
    @IBOutlet weak var historyLabel: UITextView!
    
    var generator = InterfaceGenerator()
   
    // Mark - 02. ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        generator.displayLabelList = [displayLabel01,displayLabel02,displayLabel03] // LB 초기화
    }
    
    //Mark - 03. Start button : 시작
    @IBAction func btnReplay(_ sender: UIButton) {
        generator.play()
        scoreLabel.text = "시작해볼까요?👻"
        historyLabel.text = ""
    }
    
    //Mark - 04. Clear Button (숫자 지우기)
    @IBAction func btnCancel(_ sender: UIButton) {
        generator.delete()
    }
    
    //Mark - 05. UIButton: btnNum click
    @IBAction func btnNumClick(_ sender: UIButton) {
        generator.btnClick(sender, scoreLB: scoreLabel)
    }

    //Mark - 06. GameBrain 모델을 통한 btnCheck 연산
    @IBAction func btnCheck(_ sender: UIButton) {
        generator.check(scoreLB: scoreLabel, historyLB: historyLabel)
    }
    
}

