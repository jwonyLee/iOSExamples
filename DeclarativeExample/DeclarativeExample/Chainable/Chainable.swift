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

protocol ChainAny {
    var anyObject: Any { get }
}

extension Chain: ChainAny {
    var anyObject: Any {
        return origin
    }
}

extension Chain {
    func store(to target: inout Origin?) -> Chain {
        target = origin
        return self
    }
}
