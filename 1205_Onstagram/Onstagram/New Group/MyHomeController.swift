//
//  UserProfileController.swift
//  Onstagram
//
//  Created by Kimkeeyun on 03/12/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
import Firebase

class MyHomeController: OnstagramController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MyHomeHeaderDelegate, PhotoSelectorControllerDelegate {

    // MARK: - CollectionView Properties
    var collectionView: UICollectionView?
    let cellId = "cellId"
    let mainPostCellId = "homePostCellId"
    let headerId = "headerId"
    var isGridView = true
    var isFinishedPaging = false
    
    // MARK: - DataSource
    var currentUser: User?
    var posts = [Post]()
    
    @objc fileprivate func fetchUser() {
        App.api.fetchUser(handler: { [weak self] (isSuccess) in
            if isSuccess {
                self?.currentUser = GlobalState.instance.user
                DispatchQueue.main.async {
                    self?.paginatePosts()
                }
            }else {
                print("fail to fetch user")
            }
        })
    }
    
    // MARK: - MyHomeHeaderDelegate
    func didChangeToGridView() {
        isGridView = true
        collectionView?.reloadData()
    }
    
    func didChangeToListView() {
        isGridView = false
        collectionView?.reloadData()
    }
    
    func didTapEditProfileBtn() {
        let profileImagePicker = PhotoSelectorController()
        profileImagePicker.pickerType = .ProfileImagePicker
        profileImagePicker.delegate = self
        let pickerNavi = UINavigationController(rootViewController: profileImagePicker)
        self.present(pickerNavi, animated: true, completion: nil)
    }
    
    func photoselectorDidSelectedImage(_ selectedImage: UIImage) {
        let uploadData = selectedImage.generateJPEGData()
        let filename = NSUUID().uuidString
        Storage.storage().reference()
            .child(GlobalState.Constants.users.rawValue)
            .child(filename)
            .putData(uploadData, metadata: nil) { (metadata, err) in
                if let err = err {
                    print("Failed to upload post image:", err)
                    return
                }
                guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                NotificationCenter.default.post(name: Notification.Name.uploadProfileImage,
                                                object: imageUrl)
                
                let values = ["profileImageUrl": imageUrl]
                Database.database().reference()
                    .child(GlobalState.Constants.users.rawValue)
                    .child(self.currentUser!.uid)
                    .updateChildValues(values) { (err, ref) in
                        if let err = err {
                            print(err)
                            return
                        }
                        print("Successfully saved profile image to DB")
                }
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        paginatePosts()
        setupLogOutButton()
       
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        collectionView?.register(MyHomeHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(PostGridCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(PostListCell.self, forCellWithReuseIdentifier: mainPostCellId)
      
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(paginatePosts),
                                               name: Notification.Name.newPost,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fetchUser),
                                               name: NSNotification.Name.userLogined,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(needUpdateHeader),
                                               name: NSNotification.Name.userUpdatedInfo,
                                               object: nil)
    }

    @objc fileprivate func needUpdateHeader() {
        self.currentUser = GlobalState.instance.user
        collectionView?.reloadData()
    }
    
    @objc fileprivate func paginatePosts() {
        print("Start paging for more posts")
        guard let uid = self.currentUser?.uid else { return }
        let ref = Database.database().reference().child(GlobalState.Constants.posts.rawValue).child(uid)
        var query = ref.queryOrdered(byChild: "creationDate")
        if posts.count > 0 {
            let value = posts.last?.creationDate.timeIntervalSince1970
            query = query.queryEnding(atValue: value)
        }
        
        query.queryLimited(toLast: 4).observeSingleEvent(of: .value, with: { (snapshot) in
            guard var allObjects = snapshot.children.allObjects as? [DataSnapshot] else { return }
            allObjects.reverse()
            if allObjects.count < 4 {
                self.isFinishedPaging = true
            }
            // For removing repeating images
            if self.posts.count > 0 && allObjects.count > 0 {
                allObjects.removeFirst()
            }
            guard let user = self.currentUser else { return }
            allObjects.forEach({ (snapshot) in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                var post = Post(uid: user.uid, dictionary: dictionary)
                post.key = snapshot.key
                self.posts.append(post)
            })
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }) { (err) in
            print("Failed to paginate for posts:", err)
        }
    }
    
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Setting_Off").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                //what happens? we need to present some kind of login controller
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // show you how to fire off the paginate call
        if indexPath.item == self.posts.count - 1 && !isFinishedPaging {
            print("Paginating for posts")
            paginatePosts()
        }
        
        if isGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PostGridCell
            cell.post = posts[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainPostCellId, for: indexPath) as! PostListCell
            cell.post = posts[indexPath.item]
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isGridView {
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width, height: width)
        } else {
            var height: CGFloat = 40 + 8 + 8 //username userprofileimageview
            height += view.frame.width
            height += 50
            height += 60
            return CGSize(width: view.frame.width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MyHomeHeader
        header.delegate = self
        header.user = self.currentUser
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
}

extension MyHomeController: PostListCellDelegate {
    
    func didTapComment(post: Post) {
        print(post.caption)
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    func didLike(for cell: PostListCell) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        var post = self.posts[indexPath.item]
        guard let postId = post.key else { return }
        guard let uid = self.currentUser?.uid else { return }
        
        let values = [uid: post.hasLiked == true ? 0 : 1]
        Database.database().reference().child("likes").child(postId).updateChildValues(values) { (err, _) in
            
            if let err = err {
                print("Failed to like post:", err)
                return
            }
            
            print("Successfully liked post.")
            post.hasLiked = !post.hasLiked
            self.posts[indexPath.item] = post
            self.collectionView?.reloadItems(at: [indexPath])
            
        }
    }
}




