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

    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            let swipeGesture = UISwipeGestureRecognizer(
                target: self
                , action: #selector(nextCard)
            )
            
            swipeGesture.direction = [.left, .right]
            
            playingCardView.addGestureRecognizer(swipeGesture)
            
            let pinch = UIPinchGestureRecognizer(
                target: playingCardView
                , action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:))
            )
            
            pinch.movement

            playingCardView.addGestureRecognizer(pinch)
        }
    }
    @IBAction func onCardTap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default:break
        }
    }
    
    @objc private func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

