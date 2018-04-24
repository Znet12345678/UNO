//
//  gmcomputer.swift
//  UNO
//
//  Created by Grimshaw, Steven K on 4/17/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import Foundation
import GameKit
import UIKit
import SpriteKit
import GameplayKit


class gmcomputer{
    var pool :Card?
    var cBegin : CGPoint = CGPoint()
    var cEnd : CGPoint = CGPoint()
    var playableCards : [Card] = []
    var computerDeck : [Card] = []
    var gr : GameRules?
    let regularCardChance: Int = 75
    let specialCardChance: Int = 25
    var cTurn: Bool = false
    init(pool : Card?,computerDeck : [Card],cBegin : CGPoint,cEnd : CGPoint){
        self.pool = pool
        self.computerDeck = computerDeck
        self.cBegin = cBegin
        self.cEnd = cEnd
    }
    func removFromHand(c: Card) {
        var index = 0
        while(index < computerDeck.count) {
            if c == computerDeck[index] {
                computerDeck.remove(at: index)
            }
        index += 1
        }
    }
    func updatePool(c : Card){
        pool = c
    }
    func playCard(c: Card) {
        if (cTurn) {
            if let prevCard = pool{
                
            }
            pool = c
            c.position.x = CGFloat(-Int(c.frame.height)/2 + 8)

            c.position.y = 0
            removFromHand(c : c)
        }
    }

    func draw() {
        if(cTurn) {
            //pop is a stack only function
            if let c = pool{
                var posX: Int = Int(computerDeck[computerDeck.count-1].position.x)
                var posY: Int = Int(computerDeck[computerDeck.count-1].position.y)
                if posX + 80 > Int(cEnd.x) {
                    posX = Int(cBegin.x)
                    posY -= 100
                }
                c.position.x = CGFloat(posX)
                c.position.y = CGFloat(posY)
                computerDeck.append(c)
            }
        }
    }
    func chooseRandomCard(regProb: Int, specProb: Int) {
        gr = GameRules(playerDeck: computerDeck, pool: pool)
        playableCards = (gr?.getPlayableCards())!
        //Does a quick check to see if you have multiple options
        if playableCards.count == 1 {
            playCard(c: playableCards[0])
        } else {
            
            //Get chance of card becoming a regular or special card from user
            let probabilityOfReg: Int = regProb
            let probabilityOfSpecial: Int = specProb
            
            //Get a random number between 0 - 100
            let randomNumber: Int = Int(arc4random_uniform(100))
            
            //Determine whether the CPU will choose a regular or special card
            let regChance = abs(randomNumber - probabilityOfReg)
            let specChance = abs(randomNumber - probabilityOfSpecial)
            
            //Chooses the smallest difference
            if regChance < specChance {
                for card in playableCards {
                    //Checks if card is a special card; the value of each card is in the picture names
                    //0-9 is regular; 10-14 is special
                    if card.num > 9 {
                        //Removes all usable special cards
                        playableCards.remove(at: card.num)
                        
                        //Picks a random number that aligns with the indexes of the remaining
                        let randomNumber: Int = Int(arc4random_uniform(UInt32(playableCards.count)))
                        //Plays the card
                        playCard(c: playableCards[randomNumber])
                    }
                }
            } else {
                for card in playableCards {
                    //Checks if card is a regular card; the value of each card is in the picture names
                    //0-9 is regular; 10-14 is special
                    if card.num <= 9 {
                        //Removes all usable regular cards
                        playableCards.remove(at: card.num)
                        
                        //Picks a random number that aligns with the indexes of the remaining
                        let randomNumber: Int = Int(arc4random_uniform(UInt32(playableCards.count)))
                        //Plays the card
                        playCard(c: playableCards[randomNumber])
                    }
                }
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
