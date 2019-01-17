//
//  StringArrayExtensions.swift
//  Emoji Art
//
//  Created by Jonathan Trowbridge on 1/17/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation

extension String {
    func ensureUnique(forItems items: [String]) -> [String] {
        var result = items
        
        if items.contains(self) {
            result.append("\(self) (\(UUID().uuidString))")
        } else {
            result.append(self)
        }

        return result
    }
}
