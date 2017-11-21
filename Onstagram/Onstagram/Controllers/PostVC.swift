//
//  PostVC.swift
//  Onstagram
//
//  Created by Kimkeeyun on 21/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class PostVC: UIViewController {

    // MARK: - Data Property
    var selectedImage: UIImage?
    
    // MARK: - UI Property
    var postImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationButtons()
        view.backgroundColor = .white
        view.addSubview(postImage)
        postImage.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        postImage.image = selectedImage
    }
    
    fileprivate func setupNavigationButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "New Post"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
    }
    
    @objc func handleDone() {
       self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    

}
