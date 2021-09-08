//
//  UIStackView+Chainable.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit

extension Chain where Origin: UIStackView {
    func axis(_ axis: NSLayoutConstraint.Axis) -> Chain {
        origin.axis = axis
        return self
    }

    func spacing(_ space: CGFloat) -> Chain {
        origin.spacing = space
        return self
    }

    func align(_ alignment: UIStackView.Alignment) -> Chain {
        origin.alignment = alignment
        return self
    }

    func distribution(_ distribution: UIStackView.Distribution) -> Chain {
        origin.distribution = distribution
        return self
    }
}

func HStackView() -> Chain<UIStackView> {
    return UIStackView().chain.axis(.horizontal)
}


func VStackView() -> Chain<UIStackView> {
    return UIStackView().chain.axis(.vertical)
}
