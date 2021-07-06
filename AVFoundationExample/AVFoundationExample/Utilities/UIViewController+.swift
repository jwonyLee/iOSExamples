//
//  UIViewController+.swift
//  AVFoundationExample
//
//  Created by 이지원 on 2021/07/06.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, actions: UIAlertAction...) {
        let alertViewController: UIAlertController = UIAlertController(title: title,
                                                                       message: message,
                                                                       preferredStyle: .alert)
        for action in actions {
            alertViewController.addAction(action)
        }
        self.present(alertViewController, animated: true)
    }
}
