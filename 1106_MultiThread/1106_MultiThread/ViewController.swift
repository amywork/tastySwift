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

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var mainLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    func loadImage() {
        self.imageView.loadImgData("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD7g4AMiNe0jQceNdo4BT5HmhIM4w-oA42q0UVkQbgp2UXSUSVKA")
        self.imageView2.loadImgData("https://www.visafranchise.com/wp-content/uploads/2017/09/Coffee-Photo-1.jpg")
    }
    
    /*
    func useWorkItem() {
        var value = 10
        print(value)
        let workItem = DispatchWorkItem {
            value += 5 }
        workItem.perform()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async(execute: workItem)
        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
    }
     */
    
    @IBAction func action(_ sender: UIButton) {
        
        // 저수준
        DispatchQueue.global().async {
            //code
        }
        
        // DispatchQueue를 wrapping한 클래스
        // 고수준, 속도 느림
        let op = OperationQueue()
        op.addOperation {
            //code
        }
        
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


// Img caching을 통한 UIImage 업데이트
var cache: [String:Data] = [:]
extension UIImageView {

    func loadImgData(_ urlString: String) {
        if cache.keys.contains(urlString) {
            let data = cache[urlString]!
            self.image = UIImage(data: data)
        }else {
            DispatchQueue.global().sync {
                if let data = try? Data(contentsOf: URL(string: urlString)!) {
                    DispatchQueue.main.async { [unowned self] in
                        self.image = UIImage(data: data)
                    }
                    cache.updateValue(data, forKey: urlString)
                }
            }
        }
    }

}

