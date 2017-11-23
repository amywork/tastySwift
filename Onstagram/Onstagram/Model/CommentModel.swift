//
//  CommentModel.swift
//  Onstagram
//
//  Created by 김기윤 on 23/11/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import Foundation

struct CommentModel {
    var body: String
    var key: String?
    init(contents: String) {
        self.body = contents
    }
}
