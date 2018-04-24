//
//  GameRules.swift
//  UNO
//
//  Created by Grimshaw, Steven K on 4/17/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import Foundation

class GameRules : GameScene {

    func canPlay() {
        let deck = iDeck
        let previousCard = pool[0]
    
        
        for cards in deck {
            if cards.num == previousCard.num || cards.color == previousCard.color {
                playableCards.append(cards)
            }
        }
        
        for cards in playableCards {
            cards.position.y.add(25)
        }
    }
}
