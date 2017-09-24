//
//  ViewController.swift
//  0925_BallGame
//
//  Created by Kimkeeyun on 24/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Mark - 00. UI 연관 Property
    private var isRunning: Bool = false
    private var displayLabelList: [UILabel]?
    private var selectedNumberList: [Int]?
    private var randomNumberList: [Int]?
    private var historyStr: String?
    private var displayLabelStr: String { // [Int] -> String 변환 후 전시하기 위함, Computed property
        get {
            var str: String = ""
            for i in 0..<3 { str += "\(selectedNumberList![i])" }
            return str
        }
    }
    
    //Mark - 01. UILabel
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var displayLabel01: UILabel!
    @IBOutlet weak var displayLabel02: UILabel!
    @IBOutlet weak var displayLabel03: UILabel!
    @IBOutlet weak var historyLabel: UITextView!
    
    // Mark - 02. ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabelList = [displayLabel01,displayLabel02,displayLabel03] // LB 초기화
        
    }
    
    //Mark - 03. Start button : 시작
    @IBAction func btnReplay(_ sender: UIButton) {
        isRunning = true
        resetProperty()
        randomNumberList = brain.makeRandomList()
        scoreLabel.text = "시작해볼까요? 👻"
        historyStr = "" // 초기화
        historyLabel.text = ""
    }
    
    //Mark - 04. Clear Button (숫자 지우기)
    @IBAction func btnCancel(_ sender: UIButton) {
        resetProperty()
    }
    
    //Mark - 05. UIButton: btnNum click
    @IBAction func btnNumClick(_ sender: UIButton) {
        if isRunning {
            guard let selectedNum = Int(sender.currentTitle!) else { return }
            if selectedNumberList!.count < displayLabelList!.count && !selectedNumberList!.contains(selectedNum) {
                selectedNumberList?.append(selectedNum)
                let lastIndex = selectedNumberList!.count - 1
                let inputLabel = displayLabelList![lastIndex]
                inputLabel.text = "\(selectedNum)"
            }else if selectedNumberList!.count >= displayLabelList!.count {
                scoreLabel.text = "확인 버튼을 누르세요👇🏻"
            }else if selectedNumberList!.contains(selectedNum) {
                scoreLabel.text = "숫자 중복은 안돼요 🤡"
            }
        }
    }
    
    //Mark - 06. 연산: btnCheck - UIButton
    //연산 로직을 담고 있는 SmartBrain(모델) 의 instance 생성
    let brain: SmartBrain = SmartBrain()
    
    @IBAction func btnCheck(_ sender: UIButton) {
        if isRunning && selectedNumberList!.count == displayLabelList!.count {
            let finalStr = brain.compareCheck(arr1: selectedNumberList!, arr2: randomNumberList!, inputStr: displayLabelStr)
            scoreLabel.text = finalStr.SL
            historyStr! += finalStr.HL
            historyLabel.text = historyStr
        }
        resetProperty()
    }
    
    //초기화 함수
    func resetProperty() {
        selectedNumberList = []
        for label in displayLabelList! {
            label.text = "-"
        }
    }
    
}

