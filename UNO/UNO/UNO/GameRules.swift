//
//  GameRules.swift
//  UNO
//
//  Created by Grimshaw, Steven K on 4/17/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import Foundation

class GameRules {
    
    var playerDeck: [Card] = []
    var pool: Card?
    var playableCards: [Card] = []
    
    init(playerDeck: [Card], pool: Card, playableCards: [Card]) {
        self.playerDeck = playerDeck
        self.pool = pool
        self.playableCards = playableCards
    }
    
    func canPlay() {
        let deck = playerDeck
        let previousCard = pool
    
        
        for cards in deck {
            if cards.num == previousCard?.num || cards.color == previousCard?.color {
                playableCards.append(cards)
            }
        }
        
        for cards in playableCards {
            cards.position.y.add(25)
        }
    }
}
