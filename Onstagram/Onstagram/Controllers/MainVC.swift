//
//  MainVC.swift
//  01. 테이블뷰 추가 (포스팅 완료 후 Cell에 정보 전송)
//  02. DB 연동 작업

import UIKit

class MainVC: UIViewController, ImagePickerDelegate {
  
    var currentUser: UserModel?
  
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        currentUser = DataCenter.shared.currentUser
        if let user = currentUser {
            if let img = user.profileImg {
                self.profileImgView.image = img
            }
        }

    }
    
    private func updateUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Explore"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        setConstraints()
    }
    
    // MARK: - CustomImagePickerDelegate
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
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var imgEditBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("📷Edit", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .white
        btn.addTarget(self, action: #selector(imgEditAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func imgEditAction(_ sender: UIButton) {
        let layout = UICollectionViewFlowLayout()
        let imagePicker = ImagePickerVC(collectionViewLayout: layout)
        let navi = UINavigationController(rootViewController: imagePicker)
        imagePicker.delegate = self
        self.present(navi, animated: true, completion: nil)
    }
    
    var nickNameLB: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        lb.text = "Your Nickname"
        lb.textAlignment = .center
        lb.textColor = UIColor.lightGray
        return lb
    }()
    
    var statusLB: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13, weight: .light)
        lb.text = "your status message"
        lb.textAlignment = .center
        lb.textColor = UIColor.lightGray
        return lb
    }()
    
    var editProfileBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit profile", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        btn.addTarget(self, action: #selector(editBtnHandler(_:)), for: .touchUpInside)
        return btn
    }()

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
    
    var lineView: UIView = {
        let line = UIView()
        line.layer.borderWidth = 1
        line.backgroundColor = UIColor.lightGray
        return line
    }()

}

// MARK: - Extension ** TableView Sources
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Posts"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "TEXT"
        return cell
    }
    
}



// MARK: - Extension ** Auto Layout Constraints
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
        tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        view.layoutIfNeeded()
        profileImgView.layer.cornerRadius = 16
        
    }
}

