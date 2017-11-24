//
//  CommentVC.swift
//  Onstagram
//
//  Created by 김기윤 on 23/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

// Storyboard driven!
class CommentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTF: UITextField!
    
    var parentPost: PostModel?
    var comments = [CommentModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let key = parentPost?.postKey {
            FirebaseManager.shared.loadComments(postKey: key, completion: { (isSuccess, comments) in
                if isSuccess {
                    self.comments = comments as! [CommentModel]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }
        commentTF.placeholder = "댓글을 입력하세요"
    }

    @IBAction func didTapSendBtn(_ sender: UIButton) {
        guard let body = commentTF.text else { return }
        var newComment = CommentModel(contents: body)
        parentPost?.comments.append(newComment)
        guard let key = parentPost?.postKey else { return }
        FirebaseManager.shared.uploadComment(postKey: key, body: body) { (isSuccess, key) in
            if isSuccess {
                newComment.key = key
                print("FirebaseManager.shared.uploadComment")
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = parentPost {
            return comments.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) 
        if let _ = parentPost {
            cell.textLabel?.text = comments[indexPath.row].body
        }
        return cell
    }
    
}
