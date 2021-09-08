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

        _ = UIView().chain
            .add(to: view)
            .background(color: .red)
            .cornerRadius(8)
            .size(width: 100, height: 100)
            .position(x: 50, y: 50)

        _ = UIView().chain
            .add(to: view)
            .background(color: .green)
            .cornerRadius(16)
            .size(width: 100, height: 100)
            .position(x: 80, y: 80)

        _ = UIView().chain
            .add(to: view)
            .background(color: .blue)
            .cornerRadius(32)
            .size(width: 100, height: 100)
            .position(x: 120, y: 120)

        _ = UILabel().chain
            .add(to: view)
            .text("Hello, World!")
            .font(size: 32, weight: .medium)
            .color(.cyan)
            .position(x: 100, y: 250)
    }


}

