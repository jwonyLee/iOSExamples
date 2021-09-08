//
//  SnapKit+Chainable.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    var didMoveSuperview: ControlEvent<Void> {
        let event = methodInvoked(#selector(Base.didMoveToSuperview)).map { _ in }
        return ControlEvent(events: event)
    }
}

extension Chain where Origin: UIView {
    func constraint(_ maker: @escaping (ConstraintMaker) -> Void) -> Chain {
        if let _ = origin.superview {
            origin.snp.makeConstraints(maker)
        } else {
            _ = origin.rx.didMoveSuperview
                .take(1)
                .subscribe(onNext: { _ in
                    self.origin.snp.makeConstraints(maker)
                })
        }
        return self
    }

    func updateConstraint(_ maker: @escaping (ConstraintMaker) -> Void) -> Chain {
        if let _ = origin.superview {
            origin.snp.updateConstraints(maker)
        }
        return self
    }
}
