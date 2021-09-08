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

    func add(to parent: UIView) -> Chain {
        parent.addSubview(origin)
        return self
    }

    func apply(_ block: (Origin) -> Void) -> Chain {
        block(origin)
        return self
    }
}
