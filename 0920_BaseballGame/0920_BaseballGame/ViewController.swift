//
//  ViewController.swift
//  0920_BaseballGame
//
//  Created by 김기윤 on 21/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    //Mark - 00. Property
    private var isRunning: Bool = false
    private var displayLabelList: [UILabel]?
    private var selectedNumberList: [Int]?
    var numStrike: Int = 0
    var numBall: Int = 0
    var randomNumberList: [Int]?
    var historyStr: String = ""

    //Mark - 01. UILabel
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var displayLabel01: UILabel!
    @IBOutlet weak var displayLabel02: UILabel!
    @IBOutlet weak var displayLabel03: UILabel!
    @IBOutlet weak var historyLabel: UITextView!
  
    // Mark - 02. ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabelList = [displayLabel01,displayLabel02,displayLabel03]
    }
    
    //게임 Brain 모델 의 instance 생성
    var brain: GameBrain = GameBrain()
    
    //Mark - 03. Start button Click : 시작
    @IBAction func btnReplay(_ sender: UIButton) {
        resetProperty()
        isRunning = true
        randomNumberList = brain.makeRandomList()
        historyStr = ""
        historyLabel.text = ""
        scoreLabel.text = ""
    }
    
    //Mark - 04. Clear Button (숫자 지우기)
    @IBAction func btnCancel(_ sender: UIButton) {
        resetProperty()
    }

    //Mark - 05. UIButton: btnNumber click
    @IBAction func btnNumClick(_ sender: UIButton) {
        if isRunning {
            let selectedNum = sender.tag
            if selectedNumberList!.count < displayLabelList!.count && !selectedNumberList!.contains(selectedNum) {
                selectedNumberList?.append(selectedNum)
                let lastIndex = selectedNumberList!.count - 1
                let inputLabel = displayLabelList![lastIndex]
                inputLabel.text = "\(selectedNum)"
            }else {
                scoreLabel.text = "중복 숫자 불가 🤡"
            }
        }
    }
    
    
    //Mark - 06. UIButton: btnCheck, btnCancel, btnReplay
    @IBAction func btnCheck(_ sender: UIButton) {
        if isRunning && selectedNumberList!.count == displayLabelList!.count {
        
            // Brain, 계산을 부탁해
            let result = brain.compareCheck(arr1: selectedNumberList!, arr2: randomNumberList!)

            
            //scoreLabel, history에 전시
            var displayLabelStr: String = ""
            for i in 0..<3 {
                displayLabelStr += "\(selectedNumberList![i])"
            }
            
            if result.s + result.b == 0 {
                scoreLabel.text = "3 Out!"
                historyStr += displayLabelStr + " : 3 Out! \n"
            }else if result.s == 3 {
                scoreLabel.text = "YES👌🏻👏🏻♥️"
                historyStr += displayLabelStr + " YES👌🏻👏🏻♥️"
            }else {
                scoreLabel.text = "S: \(result.s), B:  \(result.b)"
                historyStr += displayLabelStr + " S: \(result.s), B:  \(result.b) \n"
            }
            
        }
        historyLabel.text = historyStr
        resetProperty()
    }
    

    //초기화 Method
    func resetProperty() {
        selectedNumberList = []
        numStrike = 0
        numBall = 0
        for label in displayLabelList! {
            label.text = "-"
        }
    }

}
