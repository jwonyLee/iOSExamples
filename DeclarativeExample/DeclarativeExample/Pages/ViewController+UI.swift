//
//  File.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit

extension ViewController {
    func setupViews() {
        let profile = UIView().chain
            .add(to: view)
            .background(color: .gray)
            .cornerRadius(50)
            .constraint {
                $0.top.equalToSuperview().offset(150)
                $0.centerX.equalToSuperview()
                $0.size.equalTo(100)
            }
            .origin

        emailField = UITextField().chain
            .add(to: view)
            .borderStyle(.roundedRect)
            .keyboard(type: .emailAddress)
            .constraint {
                $0.top.equalTo(profile.snp.bottom).offset(50)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
                $0.height.equalTo(40)
            }
            .origin

        passwordField = UITextField().chain
            .add(to: view)
            .borderStyle(.roundedRect)
            .secure()
            .constraint {
                $0.top.equalTo(emailField.snp.bottom).offset(16)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
                $0.height.equalTo(40)
            }
            .origin

        loginButton = UIButton().chain
            .add(to: view)
            .title("LOG IN")
            .title("Fill Field", for: .disabled)
            .titleFont(size: 24, weight: .bold)
            .titleColor(.white)
            .background(color: .brown)
            .cornerRadius(12)
            .constraint {
                $0.top.equalTo(passwordField.snp.bottom).offset(32)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
                $0.height.equalTo(80)
            }
            .origin
    }
}
