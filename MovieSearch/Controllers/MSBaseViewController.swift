//
//  MSBaseViewController.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

class MSBaseViewController: UIViewController {

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = String(localizedKey: "MOVIE_SEARCH")
        self.view.backgroundColor = UIColor.background
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillHide() {
        /// Override this in child class
    }
    
    func keyboardWillShow(rect: CGRect) {
        /// Override this in child class
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            guard let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
            }
            self.keyboardWillShow(rect: endFrame)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.keyboardWillHide()
    }
}
