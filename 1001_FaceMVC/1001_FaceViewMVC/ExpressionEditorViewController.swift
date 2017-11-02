//
//  ExpressionEditorViewController.swift
//  1001_UITestStanford
//
//  Created by Kimkeeyun on 15/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class ExpressionEditorViewController: UITableViewController, UITextFieldDelegate {
    
    var name: String {
        return nameTextField?.text ?? ""
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mouthControl: UISegmentedControl!
    @IBOutlet weak var eyeControl: UISegmentedControl!
    
    
    private let eyeChoices = [FacialExpression.Eyes.open, .closed, .squinting]
    private let mouthChoices = [FacialExpression.Mouth.frown, .smirk, .neutral, .grin, .smile]
 
    
    // FacialExpression through selectedSegmentIndex
    var expression: FacialExpression {
        return FacialExpression (
            eyes: eyeChoices[eyeControl.selectedSegmentIndex],
            mouth: mouthChoices[mouthControl.selectedSegmentIndex]
        )
    }
    
    private var faceViewController: BlinkingFaceViewController?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbededFaceView" {
            faceViewController = segue.destination as? BlinkingFaceViewController
            faceViewController?.expression = expression
        }
    }
    
    @IBAction func updateFace() {
        faceViewController?.expression = expression
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // For Face Cell Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.bounds.size.width
        }else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
}
