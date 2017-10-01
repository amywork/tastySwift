//
//  Skull.swift
//  1001_UITestStanford
//
//  Created by Kimkeeyun on 01/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
@IBDesignable 
class SkullView: UIView {

    // Public API
    @IBInspectable
    var scale: CGFloat = 0.8 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var eyesOpen: Bool = false { didSet { setNeedsDisplay() } }
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } } // 1.0 is full smile, -1.0 is full frown
    @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var skullColor: UIColor = UIColor.black { didSet { setNeedsDisplay() } }
    
    
    // Pinch - UIPinchGestureRecognizer
    @objc func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer)
    {
        switch pinchRecognizer.state {
        case .changed, .ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    
    
    // 원의 반지름
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    
    // 원의 중심
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
    // 얼굴의 골격 path
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        path.lineWidth = lineWidth
        return path
    }
    
    // 눈
    private enum Eye {
        case left
        case right
    }
    
    // 눈 path
    private func pathforEye(_ eye: Eye) -> UIBezierPath {
        
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        
        let path: UIBezierPath
        
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle:  CGFloat.pi * 2, clockwise: true)
        }else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        path.lineWidth = lineWidth
        return path
    }
    
    // 입 path
    private func pathforMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        let mouthRect = CGRect(
            x: skullCenter.x - (mouthWidth / 2),
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight)
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let controlPoint1 = CGPoint(x: start.x + mouthRect.width/3, y: start.y + smileOffset)
        let controlPoint2 = CGPoint(x: end.x - mouthRect.width/3, y: start.y + smileOffset)

        let path: UIBezierPath = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        path.lineWidth = lineWidth
        return path
    }
    
    
    
    // 자주쓰는 거리
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 5
        static let skullRadiusToEyeRadius: CGFloat = 20
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 6
    }
    
    // draw()
    override func draw(_ rect: CGRect) {
        skullColor.set()
        pathForSkull().stroke()
        pathforEye(.left).stroke()
        pathforEye(.right).stroke()
        pathforMouth().stroke()
    }

}
