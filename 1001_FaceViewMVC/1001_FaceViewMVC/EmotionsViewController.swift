//
//  EmotionsViewController.swift
//  1001_UITestStanford
//
//  Created by Kimkeeyun on 02/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
class EmotionsViewController: VCLLoggingViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        
        if let faceViewController = destinationViewController as? FaceViewController,
            let identifier = segue.identifier,
            let expression = emotionalFaces[identifier] {
                 faceViewController.expression = expression
            faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
                }
            }

    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "happy": FacialExpression(eyes: .open, mouth: .smile),
        "sad": FacialExpression(eyes: .open, mouth: .frown),
        "worried": FacialExpression(eyes: .closed, mouth: .smirk)
    ]
}
