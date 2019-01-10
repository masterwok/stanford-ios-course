//
//  PlayingCard.swift
//  Playing Card
//
//  Created by Jonathan Trowbridge on 1/10/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    var suit: Suit
    var rank: Rank
    
    var description: String {
        return "Suit: \(suit), Rank: \(rank)"
    }

    enum Suit: String {
        case spades = "♠"
        case hearts = "♥"
        case diamonds = "♦"
        case clubs = "♣"
        
        static var all = [
            Suit.spades,
            Suit.hearts,
            Suit.diamonds,
            Suit.clubs
        ]
    }
    
    // Terrible representation of data (done for demo purposes)
    enum Rank {
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
                case .ace: return 1
                case .numeric(let pips): return pips
                case .face(let kind) where kind == "J": return 11
                case .face(let kind) where kind == "Q": return 12
                case .face(let kind) where kind == "K": return 13
                default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
            
            allRanks += [Rank.face("J"),Rank.face("Q"),Rank.face("K")]
            
            return allRanks
        }
    }
}
