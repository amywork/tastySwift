//
//  AddPhotoViewController.swift
//  WPhotoWitget
//
//  Created by youngmin joo on 2017. 11. 9..
//  Copyright © 2017년 youngmin joo. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController,UITextFieldDelegate,PhotoSelectorControllerDelegate {

    @IBOutlet weak var displayImageView: UIImageView!
    @IBOutlet weak var inputTitleTextField: UITextField!
    
    private var selectedImageData:Data?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func mainViewTapGestrue(_ sender: UITapGestureRecognizer) {
        inputTitleTextField.resignFirstResponder()
    }
    
    @IBAction func SavePhotoDataHandler(_ sender: UIButton) {
        if let text = inputTitleTextField.text, !text.isEmpty,
            let data = selectedImageData
        {
            DataCenter.main.addPhoto(title: text, data: data)
            NotificationCenter.default.post(name: Notification.Name.AddPhotoDataNotification, object: nil)            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func choicePhotoHandler(_ sender: UIButton) {
                
        let picker = PhotoSelectorController(collectionViewLayout: UICollectionViewFlowLayout())
//        let picker = UIImagePickerController()
        picker.photoSelectorDelegate = self
//
        let navi = UINavigationController(rootViewController: picker)
        
        self.present(navi, animated: true, completion: nil)
    }
    
    func photoselectorDidSelectedImage(_ selectedImgae: UIImage) {
        displayImageView.image = selectedImgae
        selectedImageData = UIImageJPEGRepresentation(selectedImgae, 0.5)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTitleTextField.resignFirstResponder()
        return true
    }

}


extension NSNotification.Name
{
    static let AddPhotoDataNotification:NSNotification.Name = NSNotification.Name(rawValue: "addPhotoNoti")
    
}
