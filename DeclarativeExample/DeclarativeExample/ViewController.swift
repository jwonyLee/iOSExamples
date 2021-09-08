//
//  ViewController.swift
//  DeclarativeExample
//
//  Created by 이지원 on 2021/09/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        let red = UIView().chain
            .add(to: view)
            .background(color: .red)
            .cornerRadius(8)
            .constraint {
                $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
            }
            .origin

        let green = UIView().chain
            .add(to: red)
            .background(color: .green)
            .cornerRadius(16)
            .constraint {
                $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
            }
            .origin

        _ = UIView().chain
            .add(to: green)
            .background(color: .blue)
            .cornerRadius(32)
            .constraint {
                $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
            }
            .origin

        _ = UILabel().chain
            .add(to: view)
            .text("Hello, World!")
            .font(size: 32, weight: .medium)
            .color(.cyan)
            .constraint {
                $0.center.equalToSuperview()
            }
    }


}

