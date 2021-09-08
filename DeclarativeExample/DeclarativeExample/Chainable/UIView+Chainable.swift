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

    private func add(child: UIView, to parent: UIView) {
        if let stackParent = parent as? UIStackView {
            stackParent.addArrangedSubview(child)
        } else {
            parent.addSubview(child)
        }
    }

    func add<Parent: UIView>(to parent: Parent) -> Chain {
        add(child: origin, to: parent)
        return self
    }

    func add<V: UIView>(to parentChain: Chain<V>) -> Chain {
        return add(to: parentChain.origin)
    }

    func add<V: UIView>(child: V) -> Chain {
        add(child: child, to: origin)
        return self
    }

    func add<V: UIView>(child: Chain<V>) -> Chain {
        return add(child: child.origin)
    }

    func add<V: UIView>(children: V...) -> Chain {
        children.forEach { child in add(child: child, to: origin) }
        return self
    }

    func add(children: ChainAny...) -> Chain {
        children.map { $0.anyObject }
            .map { $0 as! UIView }
            .forEach { child in add(child: child, to: origin) }
        return self
    }

    func apply(_ block: (Origin) -> Void) -> Chain {
        block(origin)
        return self
    }
}
