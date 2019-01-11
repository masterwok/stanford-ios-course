//
//  ViewController.swift
//  concentration
//
//  Created by Jonathan Trowbridge on 1/9/19.
//  Copyright © 2019 Jonathan Trowbridge. All rights reserved.
//

import UIKit

class ConcentraionViewController: UIViewController {

    @IBOutlet var cardButtons: [UIButton]!

    @IBOutlet weak var labelFlipCount: UILabel! {
        // Interesting way to set inital view states
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBAction func OnCardTouchUpInside(_ sender: UIButton) {
        concentration.flipCard(index: cardButtons.firstIndex(of: sender)!)

        updateViewComponents()
    }
    
    var theme: String  = "👻💀☠️👽👾🤖🎃🦇" {
        didSet {
            concentration = Concentration(emojis: theme)
        }
    }

    private lazy var concentration: Concentration = Concentration(emojis: theme)

    private let attributesFlipCount: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.strokeWidth: 5.0,
        NSAttributedString.Key.strokeColor: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func updateViewComponents() {
        let cards = concentration.cards
        
        updateFlipCountLabel()

        for (index, card) in cards.enumerated() {
            let cardButton = cardButtons[index]
            
            if card.isMatched {
                cardButton.setTitle(nil, for: UIControl.State.normal)
                cardButton.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.8801295161, alpha: 0)
                continue
            }

            if card.isFlipped {
                cardButton.setTitle("\(card.emoji)", for: UIControl.State.normal)
                cardButton.backgroundColor = .white
                continue
            }

            cardButton.setTitle(nil, for: UIControl.State.normal)
            cardButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
    }
    
    private func updateFlipCountLabel() {
        labelFlipCount.attributedText = NSAttributedString(
            string: "Flips: \(concentration.flipCount)",
            attributes: attributesFlipCount
        )
    }

}

