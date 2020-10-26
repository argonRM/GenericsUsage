//
//  NibLoadableView.swift
//  ReviewGenericsTest
//
//  Created by user on 11/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
