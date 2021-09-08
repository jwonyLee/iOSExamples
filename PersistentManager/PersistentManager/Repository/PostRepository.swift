//
//  PostRepository.swift
//  PersistentManager
//
//  Created by 이지원 on 2021/08/19.
//

import Foundation
import CoreData

protocol PostRepositoryInterface {
    func posts(predicate: NSPredicate?) -> Result<[Post], Error>
    func create(post: Post) -> Result<Bool, Error>
}

final class PostRepository {
    private let repository: CoreDataRepository<PostEntity>

    init(context: NSManagedObjectContext) {
        self.repository = CoreDataRepository<PostEntity>(managedObjectContext: context)
    }
}

extension PostRepository: PostRepositoryInterface {
    @discardableResult
    func posts(predicate: NSPredicate?) -> Result<[Post], Error> {
        let result = repository.get(withPredicate: predicate)
        switch result {
        case .success(let postEntities):
            let posts = postEntities.map { postEntity -> Post in
                return postEntity.toPost()
            }
            return .success(posts)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    @discardableResult
    func create(post: Post) -> Result<Bool, Error> {
        let result: Result<PostEntity, Error> = repository.create()
        switch result {
        case .success(let postEntity):
            postEntity.contents = post.contents
            return .success(true)
        case .failure(let error):
            return .failure(error)
        }
    }
}
