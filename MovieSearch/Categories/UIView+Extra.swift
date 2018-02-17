//
//  UIView+Extra.swift
//  MovieSearch
//
//  Created by Ganesh on 2/17/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Adds a view to the end of the receiver’s list of subviews using constraints
    ///
    /// - Parameters:
    ///   - view: The view to be added.
    ///   - insets: The spacing to the superview
    func addSubView(view: UIView, withEdgeInsets insets: UIEdgeInsets) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: ["childView": view]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                           options: [],
                                                           metrics: nil,
                                                           views: ["childView": view]))
    }
    
    /// Loads view from xib
    ///
    /// - Returns: Returns the `UIView` for successful load
    func loadFromXib() {
        let bundle = Bundle(for: type(of: self))
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else {
            return
        }
        guard let view = UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        self.addSubView(view: view, withEdgeInsets: .zero)
    }
}
