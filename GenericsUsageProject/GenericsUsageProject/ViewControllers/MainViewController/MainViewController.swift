//
//  ViewController.swift
//  ReviewGenericsTest
//
//  Created by user on 11/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Storyboardable {

    static var flow: Flow = .Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tableScreenPressed(_ sender: Any) {
        let vc = self.initFromStoryboard(of: PhotosListViewController.self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

