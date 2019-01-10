//
// Created by Jonathan Trowbridge on 2019-01-09.
// Copyright (c) 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation

class Concentration {

    var cardCount: Int {
        return cards.count
    }

    private(set) var flipCount = 0
    private(set) var cards = [Card]()
    private var emojis: [Character]

    init(emojis: String) {
        self.emojis = emojis.shuffled()

        initializeCards(self.emojis)
    }

    private func initializeCards(_ emojis: [Character]) {
        for emoji in emojis {
            let card = Card(emoji: emoji)

            cards.insert(contentsOf: [card, card], at: 0)
        }
    }

    private var firstFlippedCardIndex: Int?

    private func flipAllCardsDown() {
        for index in cards.indices {
            cards[index].isFlipped = false
        }
    }

     func flipCard(index: Int) {
        let card = cards[index]

        // Card already flipped, do nothing
        if card.isFlipped {
            return
        }

        flipCount += 1

        flipAllCardsDown()

        // Set card to flipped
        cards[index].isFlipped = true

        if firstFlippedCardIndex == nil {
            firstFlippedCardIndex = index
            cards[index].isFlipped = true
            return
        }
        
        cards[firstFlippedCardIndex!].isFlipped = true

        if cards[firstFlippedCardIndex!].emoji == cards[index].emoji {
            cards[firstFlippedCardIndex!].isMatched = true
            cards[index].isMatched = true
            firstFlippedCardIndex = nil
            return
        }

        firstFlippedCardIndex = nil
    }

}
