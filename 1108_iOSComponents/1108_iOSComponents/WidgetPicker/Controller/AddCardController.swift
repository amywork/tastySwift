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
        NotificationCenter.default.post(name: Notification.Name.AddCardDataNotification, object: nil)
        self.navigationController?.popViewController(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTF.resignFirstResponder()
        return true
    }
    
    @IBAction func unwindToAddCardController(_ sender: UIStoryboardSegue) {
    }

    @IBAction func choicePhotoHandler(_ sender: UIButton) {
        let picker = PhotoSelectorController(collectionViewLayout: UICollectionViewFlowLayout())
        picker.photoSelectorDelegate = self
        let navi = UINavigationController(rootViewController: picker)
        self.present(navi, animated: true, completion: nil)
        
        //let picker = UIImagePickerController()
        //picker.delegate = self
        //self.present(picker, animated: true, completion: nil)
    }
    
}


extension AddCardController: PhotoSelectorControllerDelegate {
    func photoselectorDidSelectedImage(_ selectedImgae: UIImage) {
        cardImageView.image = selectedImgae
        selectedImageData = UIImageJPEGRepresentation(selectedImgae, 0.5)
    }
}

// ImagePicker => Select Image
/*
extension AddCardController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cardImageView.image = image
            selectedImageData = UIImageJPEGRepresentation(image, 0.5)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
*/

extension NSNotification.Name {
    static let AddCardDataNotification: NSNotification.Name = NSNotification.Name(rawValue: "NewCard")
}
