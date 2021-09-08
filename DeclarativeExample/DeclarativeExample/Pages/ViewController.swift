//
//  ViewController.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: BaseViewController {
    var emailField: UITextField!
    var passwordField: UITextField!
    var loginButton: UIButton!

    func setupBinds() {
        Observable.combineLatest(
            emailField.rx.text.orEmpty.map { $0.isEmpty },
            passwordField.rx.text.orEmpty.map { $0.isEmpty }
        ) { $0 || $1 }
        .map { !$0 }
        .bind(to: loginButton.rx.isEnabled)
        .disposed(by: disposeBag)

        loginButton.rx.tap.asObservable()
            .withLatestFrom(Observable.zip(emailField.rx.text, passwordField.rx.text) { ($0, $1) })
            .filter { email, password in email != nil && password != nil }
            .map { email, password in (email!, password!) }
            .subscribe(onNext: { [weak self] email, password in
                self?.login(email: email, password: password)
            })
            .disposed(by: disposeBag)
    }

    func login(email: String, password: String) {
        print("Login Email: \(email), password: \(password)")
    }
}
