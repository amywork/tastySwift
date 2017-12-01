//
//  AddCustomItemController.swift
//  FinalStackProject
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class AddCustomController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField! // name
    @IBOutlet weak var memoTextField: UITextField! // memo
    @IBOutlet weak var payDayPicker: UIDatePicker! // payDay
    @IBOutlet weak var planType: UIButton! // PlanType
    
    @IBAction func didTapSaveBtn(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        let planStr: String = "month" // 수정!
        let payDay: Date = Date() // 수정!
        let memo: String = memoTextField.text ?? ""
        
        let newStack = StackData(name: name, planStr: planStr, payDay: payDay, memo: memo)
        DataCenter.main.addUserStack(with: newStack)
        
        NotificationCenter.default.post(name: NSNotification.Name.init("NewStack"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didTapDatePicker(_ sender: UIButton) {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
    }
    
    
    // Edit Later
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}
