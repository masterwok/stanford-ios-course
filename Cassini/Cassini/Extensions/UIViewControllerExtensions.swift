//
//  UIViewControllerExtensions.swift
//  Cassini
//
//  Created by Jonathan Trowbridge on 1/15/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit


extension UIViewController {
    
    var contents: UIViewController {
        if let navController = self as? UINavigationController {
            return navController.visibleViewController ?? self
        } else {
            return self
        }
    }
}
