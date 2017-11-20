//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

protocol Times {
    func times(_ times: Int) -> Times
}

extension Int: Times {
    func times(_ times: Int) -> Times {
        return self * times
    }
}

3.times(3)

extension String: Times {
    func times(_ times: Int) -> Times {
        return Array(0..<times)
            .map { _ in
                return self
            }.reduce("", +)
    }
}

"Why so Serious?".times(3)



let timesArray: [Times] = [27,1,2,3,"www,","Was it a cat i saw"]

timesArray.forEach { (item: Times) in
    print(item.times(3))
}


extension Times {
    func printSomeTing() {
        print("self value is: \(self)")
    }
}

3.printSomeTing()

protocol Shakeable: class {
    
}

extension Shakeable where Self: UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}

protocol Dimmable: class {
    
}

extension Dimmable where Self: UIView {
    func dim() {
        self.alpha = 0.5
    }
}

class ShakeableButton: UIButton, Shakeable {
    
}

extension UIButton: Dimmable {
    
}

class MyViewController : UIViewController {
    
    let shakeButton = ShakeableButton(type: .system)
    let normalButton = UIButton(type: .system)
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        shakeButton.setTitle("shake this button", for: .normal)
        shakeButton.frame = CGRect(x: 70, y: 200, width: 200, height: 20)
        shakeButton.addTarget(self, action: #selector(shakeButtonTap), for: .touchUpInside)
        view.addSubview(shakeButton)
        
        normalButton.setTitle("normal button", for: .normal)
        normalButton.frame = CGRect(x: 70, y: 220, width: 220, height: 20)
        normalButton.addTarget(self, action: #selector(normalButtonTap), for: .touchUpInside)
        view.addSubview(normalButton)
        
        
    }
    
    @objc func shakeButtonTap(sender: Any) {
        shakeButton.shake()
        shakeButton.dim()
    }
    
    @objc func normalButtonTap(sender: Any) {
        normalButton.dim()
    }
}
PlaygroundPage.current.liveView = MyViewController()

//: [Next](@next)
