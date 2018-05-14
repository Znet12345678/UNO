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
    var nextSkipped : Bool = false
    init(playerDeck : [Card],pool : Card?){
       
        self.playerDeck = playerDeck
        self.pool = pool
        playableCards = []
        canPlay()
    }
    func update(playerDeck : [Card],pool : Card?){
    
        playableCards = []
        self.playerDeck = playerDeck
        self.pool = pool
        canPlay()
        
    }
    func rules(previousCard: Card?, cards: Card) {
        if let pc = previousCard{
            if cards.num == pc.num || cards.clr == pc.clr {
                if cards.num == 10 {
                    nextSkipped = true
                    print("Exec")
                }
                if cards.num == 11 {
                    //reverse
                }
                if cards.num == 12 {
                    //draw function that only makes player draw if they do not use a +2
                }
                if cards.typ == .plus4 {
                    //changeColor()
                    //draw(4)
                }
                if cards.typ == .swap {
                    //changeColor()
                }
            } 
        }else{
            if cards.num == 10 {
                nextSkipped = true
                print("Exec")
            }
            if cards.num == 11 {
                //reverse
            }
            if cards.num == 12 {
                //draw function that only makes player draw if they do not use a +2
            }
           
        }
    }
    func getNextSkipped()->Bool{
        return nextSkipped
        
    }
    func canPlay() {
        
        
        if let previousCard = pool{
       
            for cards in playerDeck {
                if cards.num == previousCard.num || cards.clr == previousCard.clr || cards.num > 12 {
                    playableCards.append(cards)
                }
            }
            //for cards in playableCards {
                //cards.position.y.add(25)
           // }
        }else{
            playableCards = playerDeck
        }
    }
    func getPlayableCards()->[Card]{
            return playableCards
    }
}
