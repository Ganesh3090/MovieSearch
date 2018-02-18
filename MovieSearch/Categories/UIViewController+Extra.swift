//
//  UIViewController+Extra.swift
//  MovieSearch
//
//  Created by Ganesh on 2/18/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: - Methods

    /// Display the `UIAlertController` with default ok button
    ///
    /// - Parameters:
    ///   - title: The title for alert view
    ///   - message: The message for the alert view
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
