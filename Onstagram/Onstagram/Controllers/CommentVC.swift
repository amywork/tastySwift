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

    override func viewDidLoad() {
        super.viewDidLoad()
        commentTF.placeholder = "댓글을 입력하세요"
    }

    @IBAction func didTapSendBtn(_ sender: UIButton) {
        guard let body = commentTF.text else { return }
        var newComment = CommentModel(contents: body)
        self.parentPost?.comments.append(newComment)
        FirebaseManager.shared.uploadComment(postKey: parentPost!.postKey!, body: body) { (isSuccess, key) in
            if isSuccess {
                newComment.key = key
                print("FirebaseManager.shared.uploadComment")
            }
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let post = parentPost {
            return post.comments.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        if let post = parentPost {
            cell.textLabel?.text = post.comments[indexPath.row].body
        }
        return cell
    }
    
}

extension CommentVC: CommentDelegate {
    func postCellDidSelectedCommentBtn(_ data: PostModel) {
        self.parentPost = data
    }
}
