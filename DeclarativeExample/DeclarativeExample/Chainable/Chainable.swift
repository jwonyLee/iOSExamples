//
//  Chainable.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import Foundation

class Chain<Origin> {
    var origin: Origin

    init(origin: Origin) {
        self.origin = origin
    }
}

protocol Chainable {}

extension Chainable {
    var chain: Chain<Self> {
        return Chain(origin: self)
    }
}
