//
//  ViewController.swift
//  1001_UITestStanford
//
//  Created by Kimkeeyun on 01/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
   
    @IBOutlet weak var skullView: SkullView! {
        didSet {
            let handler = #selector(skullView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: skullView, action: handler)
            skullView.addGestureRecognizer(pinchRecognizer)
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toggleEyes(byReactingTo:)))
            skullView.addGestureRecognizer(tapRecognizer)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target:self, action: #selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            skullView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target:self, action: #selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            skullView.addGestureRecognizer(swipeDownRecognizer)
            updateUI()
        }
    }
    
    @objc func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer)
    {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    @objc func increaseHappiness()
    {
        expression = expression.happier
    }
    
    @objc func decreaseHappiness()
    {
        expression = expression.sadder
    }
  
    var expression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            updateUI()
        }
    }
  
    func updateUI() {
        switch expression.eyes {
        case .open:
            skullView?.eyesOpen = true
        case .closed:
            skullView?.eyesOpen = false
        case .squinting:
            skullView?.eyesOpen = false
        }
        skullView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [
        FacialExpression.Mouth.frown: -1.0,
        FacialExpression.Mouth.smirk: -0.5,
        FacialExpression.Mouth.neutral: 0.0,
        FacialExpression.Mouth.grin: 0.5,
        FacialExpression.Mouth.smile: 1.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var titleLabel: UILabel?
        titleLabel = UILabel()
        titleLabel?.frame = CGRect(x: 16, y: 100, width: view.bounds.size.width, height: 100)
        titleLabel?.text = "Face Kit"
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        view.addSubview(titleLabel!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

