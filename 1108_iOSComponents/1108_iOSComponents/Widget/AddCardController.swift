//
//  AddCardController.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class AddCardController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!

    @IBAction func didTapDoneBtn(_ sender: UIButton) {
        guard let name = nameTF.text, let image = cardImageView.image else { return }
        let newCard = CardData(name: name, img: image)
        NotificationCenter.default.post(name: NSNotification.Name.init("NewCard"), object: newCard)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func unwindToAddCardController(_ sender: UIStoryboardSegue) {
    }

}


/*Image Picker Extension*/
extension AddCardController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Edit profile photo img
    @IBAction func addPhotoBtn(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "📷", message: "Change Profile", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let cameraAction = UIAlertAction(title: "카메라", style: .default) { (action) in
                let imgPicker = UIImagePickerController()
                imgPicker.sourceType = .camera
                imgPicker.delegate = self
                self.present(imgPicker, animated: true, completion: nil)
            }
            actionSheet.addAction(cameraAction)
        }
        
        let photoAction = UIAlertAction(title: "사진", style: .default) { (action) in
            let imgPicker = UIImagePickerController()
            imgPicker.sourceType = .photoLibrary
            imgPicker.delegate = self
            self.present(imgPicker, animated: true, completion: nil)
        }
        actionSheet.addAction(photoAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // didFinishPickingMediaWithInfo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let url = info[UIImagePickerControllerImageURL] as? URL {
            if let data = try? Data(contentsOf: url) {
                cardImageView.image = UIImage(data: data)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

