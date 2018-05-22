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
    var done : Bool = true
    var cBegin : CGPoint = CGPoint()
    var cEnd : CGPoint = CGPoint()
    var playableCards : [Card] = []
    var computerDeck : [Card] = []
    var gr : GameRules?
    let regularCardChance: Int = 75
    let specialCardChance: Int = 25
    var poolP : CGPoint = CGPoint()
    var cTurn: Bool = false
    var drawPile : Stack = Stack()
    var nxtzPos : Int = 0
    
    init(pool : Card?,computerDeck : [Card],cBegin : CGPoint,cEnd : CGPoint,poolP : CGPoint,drawPile : Stack){
        self.pool = pool
        self.computerDeck = computerDeck
        self.cBegin = cBegin
        self.cEnd = cEnd
        self.gr = GameRules(playerDeck: self.computerDeck, pool: self.pool)
        self.playableCards = (self.gr?.getPlayableCards())!
        self.poolP = poolP
        self.drawPile = drawPile
        
    }
    func updatezPos(zpos : Int){
        self.nxtzPos = zpos
    }
    func updatePool(c : Card?){
        self.pool = c
        gr = GameRules(playerDeck: computerDeck, pool: pool)
    }
    func doneF()->Bool{
        print("Are we done?\(done)")
        return done
    }
    func removeFromHand(c: Card) {
        var index = 0
        while(index < computerDeck.count) {
            if c == computerDeck[index] {
                computerDeck.remove(at: index)
            }
        index += 1
        }
    }
    func act()->Bool{
        done = false
        print("Init")
        var c : Card?
        self.gr = GameRules(playerDeck:self.computerDeck,pool:self.pool)
        self.playableCards = (self.gr?.getPlayableCards())!
        if self.playableCards.count == 0{
            print("Computer draws")
            self.draw()
            self.done = true
            print("Done_")
            return false
        }else{
            print("choose random card")
            c = self.chooseRandomCard(regProb: 10, specProb: 3)
            if c!.typ == .plus4 || c!.typ == .swap{
                var clrs = [color:Int]()
                
                for var c : Card in computerDeck {
                    if var i = clrs[c.clr]{
                        clrs[c.clr]!+=1
                    }else{
                        clrs[c.clr] = 1
                    }
                    
                }
                var m : Int = -1
                var clr : color = .none
                for (key,val) in clrs{
                    if(key == .none){
                        
                        continue
                    }
                    m = max(m,val)
                    if m == val{
                        clr = key
                    }
                }
                print("Color = clr")
                c!.clr = clr
                if(c!.clr == .none){
                    c!.clr = .red
                }
            }
            removeFromHand(c:c!)
        }
        print("Chose random card")
        c?.setOwnr(ownr: .plyr)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            if let car = c{
                self.playCard(c:car)
                print("Played card")
            }
            print("Done")
            self.done = true
        })
        return true
        
    }
    func updatePool(c : Card){
        pool = c
    }
    func getComputerDeck()->[Card]{
        return computerDeck
    }
    func getPool()->Card?{return pool}
    func playCard(c: Card) {
       
        c.isHidden = false
        var dup : [Card] = computerDeck
        dup.append(c)
        var gr = GameRules(playerDeck:dup,pool:pool)
        var pCards : [Card] = gr.getPlayableCards()
        var playable :Bool = false
     
        for var pc in pCards{
            if(pc.isEqual(c)){
                playable = true
            }
        }
        if(playable){
            print("Computer plays \(c)")
            c.zPosition = CGFloat(nxtzPos)
            c.position.x = poolP.x
            c.position.y = poolP.y
            print("C:\(c.zPosition)")
            print("C:\(c.isHidden)")
            let neg = arc4random() % 2 == 0
            c.zRotation = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: Double.pi/6) * (neg ? -1 : 1))
            print(c.zRotation)
             pool = c
            
        }
        print("Computer card\(c)")
        gr.update(playerDeck: computerDeck, pool: pool)
        print("comp zPos:\(nxtzPos)")
    }

    func draw() {
        var gr = GameRules(playerDeck:computerDeck,pool:pool)
        var pCards : [Card] = gr.getPlayableCards()
        var playable :Bool = false
        if(drawPile.count > 0){
            let c = drawPile.pop()!
            
            var posX : Int = computerDeck.count == 0 ? Int(cBegin.x) : Int(computerDeck[computerDeck.count-1].position.x),posY : Int = computerDeck.count == 0 ? Int(cBegin.y) : Int(computerDeck[computerDeck.count-1].position.y)
            if posX + 80 > Int(cEnd.x){
                posX = Int(cBegin.x);
                posY+=100
            }
            c.position.x = CGFloat(posX+80)
            c.position.y = CGFloat(posY)
            c.isHidden = true
            computerDeck.append(c)
            gr.update(playerDeck: computerDeck, pool: pool)
            //    pTurn = false
        }

    }
    func hasSpecial(cards : [Card])->Bool{
        for var c : Card in cards{
            if(c.num > 9){
                return true
            }
        }
        return false
    }
    func onlyHasSpecial(cards : [Card])->Bool{
        for var c : Card in cards{
            if(c.num <= 9){
                return false
            }
        }
        return true
    }
    func chooseRandomCard(regProb: Int, specProb: Int)->Card {
        gr = GameRules(playerDeck: computerDeck, pool: pool)
        playableCards = (gr?.getPlayableCards())!
        //Does a quick check to see if you have multiple options
        var c : Card?
        if playableCards.count == 1 {
          //  playCard(c: playableCards[0])
            c = playableCards[0]
            pool = c
        } else {
            
            //Get chance of card becoming a regular or special card from user
            let probabilityOfReg: Int = regProb
            let probabilityOfSpecial: Int = specProb
            
            //Get a random number between 0 - 100
            let randomNumber: Int = Int(arc4random_uniform(100))
            
            //Determine whether the CPU will choose a regular or special card
            let regChance = abs(randomNumber - probabilityOfReg)
            let specChance = abs(randomNumber - probabilityOfSpecial)
            let hasSpecialB : Bool = hasSpecial(cards: playableCards)
            //Chooses the smallest difference
            if (regChance < specChance && hasSpecialB) || onlyHasSpecial(cards: playableCards) {
                for card in playableCards {
                    //Checks if card is a special card; the value of each card is in the picture names
                    //0-9 is regular; 10-14 is special
                    if card.num > 9 {
                        //Removes all usable special cards
                        
                        //Picks a random number that aligns with the indexes of the remaining
                        let randomNumber: Int = Int(arc4random_uniform(UInt32(playableCards.count)))
                        //Plays the card
                      //  playCard(c: playableCards[randomNumber])
                        c = playableCards[randomNumber]
                        pool = c
                        break
                    }
                }
            } else {
                for card in playableCards {
                    //Checks if card is a regular card; the value of each card is in the picture names
                    //0-9 is regular; 10-14 is special
                    if card.num <= 9 {
                        //Removes all usable regular cards
                        
                        //Picks a random number that aligns with the indexes of the remaining
                        let randomNumber: Int = Int(arc4random_uniform(UInt32(playableCards.count)))
                        //Plays the card
                      //  playCard(c: playableCards[randomNumber])
                        c = playableCards[randomNumber]
                        pool = c
                        break
                    }
                }
            }
        }
        
        gr?.update(playerDeck: computerDeck, pool: pool)
        return c!
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
