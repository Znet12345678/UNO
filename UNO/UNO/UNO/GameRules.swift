//
//  GameRules.swift
//  UNO
//
//  Created by Grimshaw, Steven K on 4/17/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import Foundation

class GameRules {
    var playerDeck : [Card] = []
    var playableCards : [Card] = []
    var pool : Card?
    init(playerDeck : [Card],pool : Card?){
        self.playerDeck = playerDeck
        self.pool = pool
    }
    func canPlay() {

        let deck = playerDeck
        
        if let previousCard = pool{
    
            
            for cards in deck {
                if cards.num == previousCard.num || cards.color == previousCard.color {
                    playableCards.append(cards)
                }
            }
        
            for cards in playableCards {
                cards.position.y.add(25)
            }
        }else{
            playableCards = playerDeck
        }
    }
    func getPlayableCards()->[Card]{
            return playableCards
    }
}
