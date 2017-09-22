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
    var displayLabelStr: String = ""

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
    
    //Mark - 03. Start button : 시작
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
    
    //6-1. 게임 Brain 모델 의 instance 생성
    var brain: GameBrain = GameBrain()
    
    @IBAction func btnCheck(_ sender: UIButton) {
        if isRunning && selectedNumberList!.count == displayLabelList!.count {
            
            // History 라벨에 결과 축적을 위해 이전값을 Str으로 변환하는 작업
            for i in 0..<3 {
                displayLabelStr += "\(selectedNumberList![i])"
            }
            
            // Brain, 계산을 부탁해
            let result = brain.compareCheck(arr1: selectedNumberList!, arr2: randomNumberList!)

            // Brain, 결과 스트링을 부탁해
            let finalStr = brain.tupleToString(tuple: (result.s, result.b), myStr: displayLabelStr)
            
            scoreLabel.text = finalStr.SL
            historyStr += finalStr.HL
            historyLabel.text = historyStr

        }
        resetProperty()
    }
    
    //초기화 Method
    func resetProperty() {
        selectedNumberList = []
        displayLabelStr = ""
        numStrike = 0
        numBall = 0
        for label in displayLabelList! {
            label.text = "-"
        }
    }

}
