//
//  Int+Chainable.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import Foundation

extension Int: Chainable {}

extension Chain where Origin == Int {
    func increase() -> Chain {
        origin += 1
        return self
    }

    func decrease() -> Chain {
        origin -= 1
        return self
    }
}
