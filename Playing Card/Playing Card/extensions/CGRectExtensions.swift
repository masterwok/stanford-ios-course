//
//  CGRectExtensions.swift
//  Playing Card
//
//  Created by Jonathan Trowbridge on 1/11/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func sized(by size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        
        return insetBy(dx: (width - newWidth), dy: (height - newHeight) / 2)
    }
}
