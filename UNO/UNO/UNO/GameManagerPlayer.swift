//
//  GameManagerPlayer.swift
//  UNO
//
//  Created by Schlotman, Zachary J on 4/17/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import Foundation
import UIKit
class GameManagerPlayer{
    var playerDeck : [Card] = []
    var pTurn : Bool = true
    var pool : Card?
    var drawPile : Stack = Stack()
    var frame : CGRect = CGRect()
    init(playerDeck:[Card],pTurn:Bool,pool:Card?,drawPile:Stack,frame : CGRect){
        self.playerDeck = playerDeck
        self.pTurn = pTurn
        self.pool = pool
        self.drawPile = drawPile
        self.frame = frame
        
    }
    func changeTurn(){
        pTurn = !pTurn
    }
    func removeFromHand(c : Card){
        var indx = 0
        while(indx < playerDeck.count){
            if(c == playerDeck[indx]){
                playerDeck.remove(at: indx)
            }
            indx+=1
        }
    }
    func PlayCard(c : Card){
        if(pTurn){

            c.position.x = CGFloat(-Int(frame.height)/4)
            c.position.y = 0
            if let dup = pool{
                let r : Int = Int(arc4random()) % (playerDeck.count-1)
                playerDeck.insert(dup, at: r)
            }
            pool = c
            removeFromHand(c:c)
         //   pTurn = false
        }
    }
    func draw(){
        if(pTurn && drawPile.count > 0){
            let c = drawPile.pop()!
            var posX : Int = playerDeck.count == 0 ? -Int(self.frame.width)/2+80 : Int(playerDeck[playerDeck.count-1].position.x),posY : Int = playerDeck.count == 0 ? -Int(self.frame.height)/2+80 : Int(playerDeck[playerDeck.count-1].position.y)
            if posX + 80 > Int(frame.width)/2{
                posX = -Int(frame.width)/2+80;
                posY+=100
            }
            c.position.x = CGFloat(posX+80)
            c.position.y = CGFloat(posY)
            playerDeck.append(c)
        //    pTurn = false
        }
    }
    func getPDeck()->[Card]{
        return playerDeck
    }
    func getPool()->Card?{
        if let pool = pool{
            return pool
        }
        return nil
    }
    func getDrawPile()->Stack{
        return drawPile
    }
}
