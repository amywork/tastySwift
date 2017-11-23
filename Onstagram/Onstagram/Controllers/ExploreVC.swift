//
//  ExploreVC.swift
//  Onstagram
//
//  Copyright © 2017년 yunari.me. All rights reserved.
//  Tab01. Main - Explore
//

import UIKit
import FirebaseAuth

class ExploreVC: OnstagramVC, ImagePickerDelegate {
    
    private lazy var currentUser: UserModel? = FirebaseManager.shared.currentUser
    var postData = [PostModel]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        // Observe New Post
        NotificationCenter.default.addObserver(forName: Notification.Name.newPost, object: nil, queue: nil) { [weak self] (noti) in
            let newPost = noti.object as! PostModel
            guard let index = self?.postData.count else { return }
            self?.postData.append(newPost)
            self?.tableView.reloadData()
            guard let data = newPost.imageData else { return }
            FirebaseManager.shared.uploadPost(imgData: data, contents: newPost.contents, index : index)
        }
        
        // Observe User change
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.fetchUserData()
        }
    }
    
    // MARK: - Setup
    private func setUp() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Explore"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: "PostCell")
        setConstraints() // Auto Layout
        fetchUserData() // load user data
    }
    
    // MARK: - Fetch User
    private func fetchUserData() {
        FirebaseManager.shared.loadCurrentUser { [weak self] (snapshot) in
            self?.currentUser?.addUserInfo(with: snapshot as! [String : Any])
            self?.nickNameLB.text = self?.currentUser?.nickName
            self?.statusLB.text = self?.currentUser?.statusMessage
            if let url = self?.currentUser?.profileImgUrl {
                self?.profileImgView.loadImage(URLstring: url, completion: { (isSuccess) in
                    if isSuccess {
                        print("프로필 이미지 업로드 성공")
                    }else {
                        print("프로필 이미지 업로드 실패")
                    }
                })
            }
            if let posts = self?.currentUser?.posts {
                self?.postData = posts
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - ImagePickerDelegate
    func photoselectorDidSelectedImage(_ selectedImgae: UIImage) {
        self.profileImgView.image = selectedImgae
        FirebaseManager.shared.currentUser?.profileImg = selectedImgae
        if let data = FirebaseManager.shared.currentUser?.profileImgData {
            FirebaseManager.shared.uploadImg(selectedImgData: data)
        }
    }
    
    // MARK: - UI Property
    var tableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    var profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "NoImage") // default image
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var imgEditBtn : UIButton = {
        let btn = UIButton()
        let str = NSAttributedString(string: "edit",
                                     attributes: [.font : UIFont.systemFont(ofSize: 13, weight: .regular),
                                                  .foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        btn.setAttributedTitle(str, for: .normal)
        btn.addTarget(self, action: #selector(imgEditAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func imgEditAction(_ sender: UIButton) {
        let imagePicker = ImagePickerVC(collectionViewLayout: UICollectionViewFlowLayout())
        let navi = UINavigationController(rootViewController: imagePicker)
        imagePicker.delegate = self
        imagePicker.pickerType = ImagePickerLoadType.ProfileImagePicker
        self.present(navi, animated: true, completion: nil)
    }
    
    var nickNameLB: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    var statusLB: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 15, weight: .light)
        lb.textAlignment = .center
        lb.textColor = .black
        return lb
    }()
    
    var lineView: UIView = {
        let line = UIView()
        line.layer.borderWidth = 1
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    var editProfileBtn: UIButton = {
        let btn = UIButton()
        let str = NSAttributedString(string: "프로필 수정하기",
                                     attributes: [.font : UIFont.systemFont(ofSize: 13, weight: .regular),
                                                  .foregroundColor : #colorLiteral(red: 1, green: 0.1607843137, blue: 0.4078431373, alpha: 1)])
        btn.setAttributedTitle(str, for: .normal)
        btn.addTarget(self, action: #selector(editBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Btn Handlers
    @objc func editBtnHandler(_ sender : UIButton) {
        let alertController = UIAlertController(title: "프로필 설정",
                                                message: "나의 프로필 메시지 설정하기",
                                                preferredStyle: .alert)
        
        alertController.addTextField { (tf) in
            tf.placeholder = "닉네임을 입력하세요"
        }
        
        alertController.addTextField { (tf) in
            tf.placeholder = "상태 메시지를 입력하세요"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self](action) in
            guard let nickName = alertController.textFields![0].text, !nickName.isEmpty else { return } // 알럿을 좌우로 흔들어주면 좋을듯
            guard let statusText = alertController.textFields![1].text, !statusText.isEmpty else {return}
            self?.nickNameLB.text = nickName
            self?.statusLB.text = statusText
            FirebaseManager.shared.uploadUserInfo(nickName: nickName, status: statusText)
        }
        
        let cancelActoin = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelActoin)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

/* Extension : TableView */
extension ExploreVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Posts"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.postData = postData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

/* Extension : Auto Layout Constraints */
extension ExploreVC {
    
    private func setConstraints() {
        let profileImgStackView = UIStackView(arrangedSubviews: [profileImgView, imgEditBtn])
        
        self.view.addSubview(profileImgStackView)
        profileImgStackView.translatesAutoresizingMaskIntoConstraints = false
        imgEditBtn.translatesAutoresizingMaskIntoConstraints = false
        imgEditBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        profileImgStackView.alignment = .fill
        profileImgStackView.axis = .vertical
        profileImgStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImgStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        profileImgStackView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        profileImgStackView.heightAnchor.constraint(equalToConstant: 96).isActive = true
        let labelStackView = UIStackView(arrangedSubviews: [nickNameLB, statusLB, editProfileBtn])
        self.view.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.alignment = .fill
        labelStackView.distribution = .equalSpacing
        labelStackView.spacing = 2
        labelStackView.axis = .vertical
        labelStackView.topAnchor.constraint(equalTo: profileImgStackView.bottomAnchor).isActive = true
        labelStackView.centerXAnchor.constraint(equalTo: profileImgStackView.centerXAnchor).isActive = true
        labelStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        labelStackView.heightAnchor.constraint(equalTo: profileImgStackView.heightAnchor, multiplier: 1).isActive = true
        
        self.view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        lineView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 24).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        view.layoutIfNeeded()
    }
}

