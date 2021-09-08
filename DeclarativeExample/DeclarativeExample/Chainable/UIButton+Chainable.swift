//
//  UIButton+Chainable.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit

extension Chain where Origin: UIButton {
    func title(_ text: String, for state: UIControl.State = .normal) -> Chain {
        origin.setTitle(text, for: state)
        return self
    }

    func titleColor(_ color: UIColor, for state: UIControl.State = .normal) -> Chain {
        origin.setTitleColor(color, for: state)
        return self
    }

    func titleFont(_ font: UIFont) -> Chain {
        origin.titleLabel?.font = font
        return self
    }

    func titleFont(size: CGFloat, weight: UIFont.Weight) -> Chain {
        return self.titleFont(UIFont.systemFont(ofSize: size, weight: weight))
    }

}
