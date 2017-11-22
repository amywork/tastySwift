//
//  PostVC.swift
//  Onstagram
//
//  Created by Kimkeeyun on 21/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class PostVC: OnstagramVC {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationButtons()
        setupUI()
    }
    
    // MARK: - Data Property
    var selectedImage: UIImage?
    
    // MARK: - UI Property
    var postImageView : UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    var contentsTextView: UITextView = {
        let tv = UITextView()
        return tv
    }()
    
    // MARK: - setup UI
    private func setupUI() {
        view.backgroundColor = .white
        postImageView.image = selectedImage
        setConstraints()
    }
    
    fileprivate func setupNavigationButtons() {
        navigationItem.title = "New Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
    }
    
    // MARK: - Handler method
    @objc func handleDone() {
        guard let contents = contentsTextView.text, !contents.isEmpty else {return}
        guard let image = selectedImage else {return}
        let newPost = PostModel(img: image, contents: contents)
        NotificationCenter.default.post(name: Notification.Name.newPost, object: newPost)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

/* Extension : Auto Layout Constraints */
extension PostVC {
    private func setConstraints() {
        self.view.addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        postImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        postImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        self.view.addSubview(contentsTextView)
        contentsTextView.translatesAutoresizingMaskIntoConstraints = false
        contentsTextView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 16).isActive = true
        contentsTextView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        contentsTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 16).isActive = true
        contentsTextView.heightAnchor.constraint(equalTo: self.postImageView.heightAnchor).isActive = true
    }
}

