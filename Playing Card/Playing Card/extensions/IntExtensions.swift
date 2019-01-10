//
//  IntExtensions.swift
//  Playing Card
//
//  Created by Jonathan Trowbridge on 1/10/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation


extension Int {
    var arc4Random: Int {
        if self == 0 {
            return 0
        }
        
        if self > 0 {
            return Int(arc4random_uniform(UInt32(abs(self))))
        }
        
        return -Int(arc4random_uniform(UInt32(abs(self))))
    }
}
