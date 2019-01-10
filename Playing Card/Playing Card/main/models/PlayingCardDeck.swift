//
//  PlayingCardDeck.swift
//  Playing Card
//
//  Created by Jonathan Trowbridge on 1/10/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    private(set) var cards = [PlayingCard]()
    
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(
                    suit: suit,
                    rank: rank
                ))
            }
        }
        
        // Shuffle the cards
        cards = cards.shuffled()
    }
    
    mutating func draw() -> PlayingCard? {
        return cards.count == 0
            ? nil
            : cards.remove(at: cards.count.arc4Random)
    }
}
