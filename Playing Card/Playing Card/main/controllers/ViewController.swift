//
//  ViewController.swift
//  Playing Card
//
//  Created by Jonathan Trowbridge on 1/10/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cardCount = deck.cards.count

        for _ in 1...cardCount {
            if let card = deck.draw() {
                print("\(card)")
            }
        }

    }


}

