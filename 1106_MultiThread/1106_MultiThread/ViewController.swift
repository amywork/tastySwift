//
//  ViewController.swift
//  1106_MultiThread
//
//  Created by 김기윤 on 06/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//  Timer.scheduledTimer: 코드 있는 부분에서 run roop에 바로 보내져서 바로 시작
//  Timer() init 하면 timer.fire()해야지만 시작
//  Timer.invalidate 하면 중단

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLB: UILabel!
    @IBAction func action(_ sender: UIButton) {
        longTimeAction2()
        mainLB.text = "Thread Test"
    }
    
    // Timer는 메인 스레드에서 돌지만, UI도 같이 돌리는게 가능하다.
    func longTimeAction1() {
        var count = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
            self.mainLB.text = String(count)
            count += 1
        }
    }
    
    // MainLoop
    func longTimeAction2() {
        var total = 0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (t) in
            for n in 1...1000000 {
                total += n
                print(total)
            }
        }
    }

}

