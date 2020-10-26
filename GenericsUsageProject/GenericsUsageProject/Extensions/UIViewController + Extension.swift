//
//  UIViewController + Extension.swift
//  ReviewGenericsTest
//
//  Created by user on 11/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

protocol Storyboardable {
    static var flow: Flow { get }
}

extension UIViewController {
    func initFromStoryboard<T>(of type: T.Type) -> T where T: UIViewController & Storyboardable {
       
        let stringID = String(describing: type)
        let storyboard = UIStoryboard.storyboard(with: T.flow)
        guard let vc = storyboard.instantiateViewController(withIdentifier: stringID) as? T else {
            fatalError("Could not instantiate initial storyboard with name: ")
        }
        return vc
    }
}



