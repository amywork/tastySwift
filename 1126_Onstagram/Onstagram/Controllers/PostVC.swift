//
//  PostVC.swift
//  Onstagram
//
//  Copyright © 2017년 yunari.me. All rights reserved.
//

import UIKit

class PostVC: OnstagramVC, UITextViewDelegate {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Data Property
    var selectedImage: UIImage?
    
    // MARK: - UI Property
    var postImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var contentsTextView: UITextView = {
        let tv = UITextView()
        tv.text = "새로운 포스트를 작성하세요"
        tv.textColor = .lightGray
        return tv
    }()
    
    // MARK: - setup UI
    private func setUp() {
        view.backgroundColor = .white
        setupNavigationButtons()
        contentsTextView.delegate = self
        postImageView.image = selectedImage
        setConstraints()
    }
    
    fileprivate func setupNavigationButtons() {
        navigationItem.title = "Add New Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(handleDone))
    }
    
    // MARK: - Handler method
    @objc func handleDone() {
        guard let image = selectedImage else { return }
        guard let contents = contentsTextView.text, !contents.isEmpty else {
            let alertController = UIAlertController(title: "포스트 내용을 입력하세요",
                                                    message: "입력된 내용이 없습니다",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let newPost = PostModel(img: image, contents: contents)
        NotificationCenter.default.post(name: Notification.Name.newPost, object: newPost)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCancel() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.contentsTextView.text = ""
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

