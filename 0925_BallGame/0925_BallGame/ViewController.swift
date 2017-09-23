//
//  ViewController.swift
//  0925_BallGame
//
//  Created by Kimkeeyun on 24/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //Mark - 05. UIButton: btnNum click
    @IBAction func btnNumClick(_ sender: UIButton) {
        if isRunning {
            let selectedNum = sender.tag
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

