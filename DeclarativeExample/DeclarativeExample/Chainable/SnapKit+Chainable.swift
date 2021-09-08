//
//  SnapKit+Chainable.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit
import SnapKit

extension Chain where Origin: UIView {
    func constraint(_ maker: (ConstraintMaker) -> Void) -> Chain {
        origin.snp.makeConstraints(maker)
        return self
    }

    func updateConstraint(_ maker: (ConstraintMaker) -> Void) -> Chain {
        origin.snp.updateConstraints(maker)
        return self
    }
}
