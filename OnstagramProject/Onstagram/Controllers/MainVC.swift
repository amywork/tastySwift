//
//  MainVC.swift
//


import UIKit

class MainVC: UIViewController {
    
    // MARK: - UI Property
    var profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var nameLB: UILabel = {
        let lb = UILabel()
        lb.text = "NAME: " + DataCenter.shared.currentUser!.email
        lb.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return lb
    }()
    
    var detailLB: UILabel = {
        let lb = UILabel()
        lb.text = "Welcome to Onstagram"
        lb.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return lb
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        self.view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        self.view.addSubview(profileImgView)
        profileImgView.translatesAutoresizingMaskIntoConstraints = false
        profileImgView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        profileImgView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        profileImgView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 56).isActive = true
        profileImgView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36).isActive = true
        let lbStackView = UIStackView(arrangedSubviews: [nameLB,detailLB])
        self.view.addSubview(lbStackView)
        lbStackView.translatesAutoresizingMaskIntoConstraints = false
        lbStackView.alignment = .fill
        lbStackView.distribution = .fillEqually
        lbStackView.axis = .vertical
        lbStackView.leadingAnchor.constraint(equalTo: profileImgView.trailingAnchor, constant: 16).isActive = true
        lbStackView.centerYAnchor.constraint(equalTo: profileImgView.centerYAnchor, constant: 0).isActive = true
        lbStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 16).isActive = true
    }
}

