//
//  UIStoryboard + Extension.swift
//  ReviewGenericsTest
//
//  Created by user on 11/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

enum Flow: String  {
    case Main
    case Table
}

extension UIStoryboard {
    
    static func storyboard(with flow: Flow) -> UIStoryboard {
        return UIStoryboard(name: flow.rawValue, bundle: nil)
    }
}
