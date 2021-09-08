//
//  File.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit

extension ViewController {
    func setupViews() {
        let stack = VStackView()
            .add(to: view)
            .spacing(20)
            .constraint {
                $0.top.equalToSuperview().offset(100)
                $0.leading.equalToSuperview().offset(20)
                $0.trailing.equalToSuperview().offset(-20)
                $0.centerX.equalToSuperview()
            }
            .add(children:

                    UIView().chain
                    .add(child:
                            UIView().chain
                            .background(color: .gray)
                            .cornerRadius(50)
                            .constraint {
                                $0.top.bottom.centerX.equalToSuperview()
                                $0.size.equalTo(100)
                            }
                    ).origin,

                 Spacer(height: 80).origin,

                 UITextField().chain
                    .borderStyle(.roundedRect)
                    .keyboard(type: .emailAddress)
                    .constraint {
                        $0.height.equalTo(40)
                    }.origin,

                 UITextField().chain
                    .borderStyle(.roundedRect)
                    .secure()
                    .constraint {
                        $0.height.equalTo(40)
                    }.origin,

                 Spacer(height: 30).origin,

                 UIButton().chain
                    .title("LOG IN")
                    .title("Fill Field", for: .disabled)
                    .titleFont(size: 24, weight: .bold)
                    .titleColor(.white)
                    .background(color: .brown)
                    .cornerRadius(12)
                    .constraint {
                        $0.height.equalTo(60)
                    }.origin
            )

        //        emailField = UITextField().chain
        //            .add(to: stack)
        //            .borderStyle(.roundedRect)
        //            .keyboard(type: .emailAddress)
        //            .constraint {
        //                $0.height.equalTo(40)
        //            }
        //            .origin
        //
        //        passwordField = UITextField().chain
        //            .add(to: stack)
        //            .borderStyle(.roundedRect)
        //            .secure()
        //            .constraint {
        //                $0.height.equalTo(40)
        //            }
        //            .origin
        //
        //        loginButton = UIButton().chain
        //            .add(to: stack)
        //            .title("LOG IN")
        //            .title("Fill Field", for: .disabled)
        //            .titleFont(size: 24, weight: .bold)
        //            .titleColor(.white)
        //            .background(color: .brown)
        //            .cornerRadius(12)
        //            .constraint {
        //                $0.height.equalTo(60)
        //            }
        //            .origin
    }
}
