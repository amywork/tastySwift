//
//  DetailViewController.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class AddCardController: UIViewController, UITextFieldDelegate {

    private var selectedImageData: Data?
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
   
    @IBAction func didTapDoneBtn(_ sender: UIButton) {
        guard let name = nameTF.text, !name.isEmpty, let _ = selectedImageData else { return }
        
        // POST to server
        
        
        NotificationCenter.default.post(name: Notification.Name.AddCardDataNotification, object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTF.resignFirstResponder()
        return true
    }

}

extension AddCardController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBAction func choicePhotoHandler(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cardImageView.image = image
            selectedImageData = UIImageJPEGRepresentation(image, 0.5)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension NSNotification.Name {
    static let AddCardDataNotification: NSNotification.Name = NSNotification.Name(rawValue: "NewCard")
}

