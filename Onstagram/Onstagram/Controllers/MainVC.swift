//
//  MainVC.swift
//  01. 테이블뷰 추가 (포스팅 완료 후 Cell에 정보 전송)
//  02. DB 연동 작업

import UIKit

class MainVC: OSViewController, ImagePickerDelegate {
  
    var currentUser: UserModel?
    var postData = [PostModel]()
    var seperator: Bool = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        NotificationCenter.default.addObserver(forName: Notification.Name.newPost, object: nil, queue: nil) {[weak self] (noti) in
            let filename = NSUUID().uuidString
            let newPost = noti.object as! PostModel
            guard let index = self?.postData.count else {return}
            DataCenter.shared.uploadPost(img: newPost.imageData!, contents: newPost.contents, filename : filename, index : index) //global
            self?.postData.append(newPost)
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Setup UI
    private func updateUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Explore"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        setConstraints()
        fetchUserData()
    }
    
    // MARK: - Fetch User
    private func fetchUserData() {
        DataCenter.shared.loadCurrentUser { [weak self] (user, snapshot) in
            self?.currentUser = user
            self?.currentUser?.addUserInfo(with: snapshot as! [String : Any])
            self?.nickNameLB.text = self?.currentUser?.nickName
            self?.statusLB.text = self?.currentUser?.status
            self?.profileImgView.loadImage(URLstring: (self?.currentUser?.profileImgUrl)!, completion: { (data) in
                print("프로필 이미지 로드 성공")
            })
            if let posts = self?.currentUser?.posts {
                self?.postData = posts
            }
        }
    }
    
    // MARK: - ImagePickerDelegate
    func photoselectorDidSelectedImage(_ selectedImgae: UIImage) {
        self.profileImgView.image = selectedImgae
        DataCenter.shared.currentUser?.profileImg = selectedImgae
        if let data = DataCenter.shared.currentUser?.profileImgData {
            let filename = NSUUID().uuidString
            DataCenter.shared.uploadImg(selectedImgData: data , filename: filename)
        }
    }
    
    // MARK: - UI Property
    var tableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    var profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile") // default image
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    var imgEditBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("📷Edit", for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(imgEditAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func imgEditAction(_ sender: UIButton) {
        
        let imagePicker = ImagePickerVC(collectionViewLayout: UICollectionViewFlowLayout())
        let navi = UINavigationController(rootViewController: imagePicker)
        imagePicker.delegate = self
        seperator = true
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
                                                  NSAttributedStringKey.foregroundColor : #colorLiteral(red: 1, green: 0.1607843137, blue: 0.4078431373, alpha: 1)])
        btn.setAttributedTitle(str, for: .normal)
        btn.addTarget(self, action: #selector(editBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()

    // MARK: - Btn Handlers
    @objc func editBtnHandler(_ sender : UIButton) {
        let alertController = UIAlertController(title: "프로필 설정",
                                                message: "닉네임과 상태 메시지를 입력하세요",
                                                preferredStyle: .alert)
        
        alertController.addTextField { (tf) in
            tf.placeholder = "나의 닉네임 입력"
        }
        
        alertController.addTextField { (tf) in
            tf.placeholder = "나의 상태 입력"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self](action) in
            guard let nickName = alertController.textFields![0].text, !nickName.isEmpty else { return }
            guard let statusText = alertController.textFields![1].text, !statusText.isEmpty else {return}
            self?.nickNameLB.text = nickName
            self?.statusLB.text = statusText
            DataCenter.shared.uploadUserInfo(nickName: nickName, status: statusText)
        }
        
        let cancelActoin = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelActoin)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

/* Extension : TableView */
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Posts"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
     }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        if let url = postData[indexPath.row].imgUrl {
            cell.imageView?.loadImage(URLstring: url, completion: { (data) in
                cell.reloadInputViews()
            })
        }
        
        cell.textLabel?.text = postData[indexPath.row].contents
        cell.imageView?.image = postData[indexPath.row].image
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}

/* Extension : Auto Layout Constraints */
// 나중에 UIView의 extension 메소드로 정리
extension MainVC {
    
    private func setConstraints() {
        let profileImgStackView = UIStackView(arrangedSubviews: [profileImgView, imgEditBtn])
        self.view.addSubview(profileImgStackView)
        profileImgStackView.translatesAutoresizingMaskIntoConstraints = false
        profileImgStackView.alignment = .fill
        profileImgStackView.distribution = .fillProportionally
        profileImgStackView.axis = .vertical
        profileImgStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImgStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        profileImgStackView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        profileImgStackView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        let labelStackView = UIStackView(arrangedSubviews: [nickNameLB, statusLB, editProfileBtn])
        self.view.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.alignment = .fill
        labelStackView.distribution = .equalSpacing
        labelStackView.spacing = 2
        labelStackView.axis = .vertical
        labelStackView.topAnchor.constraint(equalTo: profileImgStackView.bottomAnchor, constant: 24).isActive = true
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
        profileImgView.layer.cornerRadius = 16
        
    }
}

