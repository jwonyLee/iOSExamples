//
//  UITextField+Chainable.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit

extension Chain where Origin: UITextField {
    func borderStyle(_ style: UITextField.BorderStyle) -> Chain {
        origin.borderStyle = style
        return self
    }

    func keyboard(type: UIKeyboardType) -> Chain {
        origin.keyboardType = type
        return self
    }

    func secure(_ enabled: Bool = true) -> Chain {
        origin.isSecureTextEntry = enabled
        return self
    }
}
