//
// Created by Jonathan Trowbridge on 2019-01-09.
// Copyright (c) 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation

struct Card {

    var isFlipped: Bool = false
    var isMatched: Bool = false
    var emoji: Character

    init(emoji: Character) {
        self.emoji = emoji
    }
}
