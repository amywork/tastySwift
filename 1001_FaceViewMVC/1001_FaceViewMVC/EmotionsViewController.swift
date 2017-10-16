//
//  EmotionsViewController.swift
//  1001_UITestStanford
//
//  Created by Kimkeeyun on 02/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
class EmotionsViewController: UITableViewController
{
    
    // MARK -- Model : Array that contains tuple
    private var emotionalFaces: [(name: String, expression: FacialExpression)] = [
        ("Sad", FacialExpression(eyes: .closed, mouth: .frown)),
        ("Happy", FacialExpression(eyes: .open, mouth: .smile)),
        ("Worried", FacialExpression(eyes: .open, mouth: .smirk))
    ]
    
    // MARK -- UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionalFaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion Cell", for: indexPath)
        cell.textLabel?.text = emotionalFaces[indexPath.row].name
        return cell
    }
    
    // MARK -- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        
        if let faceViewController = destinationViewController as? FaceViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            faceViewController.expression = emotionalFaces[indexPath.row].expression
            faceViewController.navigationItem.title = emotionalFaces[indexPath.row].name
        }
    }

    /*Dictionary that contains Sting : FacialExpression
    private let emotionalFacesDic: Dictionary<String,FacialExpression> = [
        "happy": FacialExpression(eyes: .open, mouth: .smile),
        "sad": FacialExpression(eyes: .open, mouth: .frown),
        "worried": FacialExpression(eyes: .closed, mouth: .smirk)
    ]
    
    let identifier = segue.identifier,
    let expression = emotionalFacesDic[identifier] {
        faceViewController.expression = expression
        faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
    }*/
    

}
