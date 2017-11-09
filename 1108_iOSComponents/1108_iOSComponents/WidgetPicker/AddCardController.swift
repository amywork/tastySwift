//
//  AddCardController.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class AddCardController: UIViewController, UITextFieldDelegate {

    private var selectedImageData: Data?
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
    
    @IBAction func didTapDoneBtn(_ sender: UIButton) {
        guard let name = nameTF.text, !name.isEmpty, let data = selectedImageData else { return }
        DataCenter.main.addCard(name: name, data: data)
        NotificationCenter.default.post(name: NSNotification.Name.init("NewCard"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTF.resignFirstResponder()
        return true
    }
    
    @IBAction func unwindToAddCardController(_ sender: UIStoryboardSegue) {
    }

    @IBAction func choicePhotoHandler(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
}

// ImagePicker => Select Image
extension AddCardController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cardImageView.image = image
            selectedImageData = UIImageJPEGRepresentation(image, 0.5)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

