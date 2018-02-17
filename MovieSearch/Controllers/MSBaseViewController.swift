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

        self.title = String(localizedKey: "Movie Search")
        self.view.backgroundColor = UIColor.background
    }
}
