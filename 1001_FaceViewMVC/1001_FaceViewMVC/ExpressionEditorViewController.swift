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
    
    private let eyeChoices = [FacialExpression.Eyes.open, .closed, .squinting]
    private let mouthChoices = [FacialExpression.Mouth.frown, .grin, .neutral, .smile, .smirk]
    var expression: FacialExpression {
        return FacialExpression (
            eyes: eyeChoices[eyeControl.selectedSegmentIndex],
            mouth: mouthChoices[mouthControl.selectedSegmentIndex]
        )
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateFace() {
    }
    
    
    @IBOutlet weak var mouthControl: UISegmentedControl!
    @IBOutlet weak var eyeControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.bounds.size.width
        }else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
}
