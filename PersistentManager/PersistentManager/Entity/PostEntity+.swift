//
//  PostEntity+.swift
//  PersistentManager
//
//  Created by 이지원 on 2021/08/19.
//

import Foundation

extension PostEntity {
    func toPost() -> Post {
        Post(contents: self.contents ?? "")
    }
}
