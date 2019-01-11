//
//  CGPoint.swift
//  Playing Card
//
//  Created by Jonathan Trowbridge on 1/11/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
