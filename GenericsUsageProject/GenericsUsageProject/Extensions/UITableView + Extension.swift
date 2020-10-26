//
//  UITableView + Extension.swift
//  ReviewGenericsTest
//
//  Created by user on 11/5/19.
//  Copyright © 2019 Roman. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(of type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type.self))
    }
    
    func register<T: UITableViewCell>(of type: T.Type) where T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: type.self))
    }
    
    func tableViewCell<T: UITableViewCell>(of type: T.Type, path: IndexPath) -> T {
          guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: type.self), for: path) as? T else {
              fatalError(String(describing: type.self) + " not found")
          }
          return cell
    }
}

