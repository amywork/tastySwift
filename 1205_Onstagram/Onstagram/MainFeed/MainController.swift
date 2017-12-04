//
//  MainController.swift
//  Onstagram
//
//  Created by Kimkeeyun on 03/12/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit
import Firebase

class MainController: OnstagramController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MainPostCellDelegate {
    
    var currentUser: User?
    var collectionView: UICollectionView?
    let cellId = "cellId"
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        fetchCurrentUserPosts()
        
        // collectionView
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.view.addSubview(collectionView!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        collectionView?.register(MainPostCell.self, forCellWithReuseIdentifier: cellId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        // newPost
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleRefresh),
                                               name: Notification.Name.newPost,
                                               object: nil)
    }
    
    fileprivate func fetchUser() {
        guard let uid = GlobalState.instance.uid, let email = GlobalState.instance.email else { return }
        self.currentUser = User(uid: uid, email: email)
    }
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchCurrentUserPosts()
    }

    fileprivate func fetchCurrentUserPosts() {
        guard let uid = currentUser?.uid else { return }
        App.api.fetchPosts(uid: uid, handler: { [weak self] (posts) in
            self?.posts = posts
            self?.posts.sort(by: { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            })
            self?.collectionView?.reloadData()
        })
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 8 + 8 //username userprofileimageview
        height += view.frame.width
        height += 50
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainPostCell
        cell.post = posts[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func didTapComment(post: Post) {
        print(post.caption)
        let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    func didLike(for cell: MainPostCell) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        
        var post = self.posts[indexPath.item]
        print(post.caption)
        
        guard let postId = post.id else { return }
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
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


