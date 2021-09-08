//
//  BaseViewController.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit
import RxSwift
import RxCocoa

@objc protocol BaseViewControllerCustomizable {
    @objc optional func setupViews()
    @objc optional func setupBinds()
}

class BaseViewController: UIViewController, BaseViewControllerCustomizable {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupViews()
        _setupBindings()
    }

    private func _setupViews() {
        view.backgroundColor = .white
        (self as BaseViewControllerCustomizable).setupViews?()
    }

    private func _setupBindings() {
        let tapper = UITapGestureRecognizer()
        tapper.rx.event
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            }).disposed(by: disposeBag)
        view.addGestureRecognizer(tapper)
        (self as BaseViewControllerCustomizable).setupBinds?()
    }
}
