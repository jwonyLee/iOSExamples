//
//  UIView+Chainable.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit

extension UIView: Chainable {}

extension Chain where Origin: UIView {
    func background(color: UIColor) -> Chain {
        origin.backgroundColor = color
        return self
    }

    func cornerRadius(_ r: CGFloat) -> Chain {
        origin.layer.cornerRadius = r
        origin.clipsToBounds = true
        return self
    }

    func add<Parent: UIView>(to parent: Parent) -> Chain {
        if let stackParent = parent as? UIStackView {
            stackParent.addArrangedSubview(origin)
        } else {
            parent.addSubview(origin)
        }
        return self
    }

    func add<V: UIView>(to parentChain: Chain<V>) -> Chain {
        return add(to: parentChain.origin)
    }

    func apply(_ block: (Origin) -> Void) -> Chain {
        block(origin)
        return self
    }
}
