//
//  GameManagerPlayer.swift
//  UNO
//
//  Created by Schlotman, Zachary J on 4/17/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import Foundation
import UIKit
struct DrawStruct{
    var pos : CGPoint
    var c : Card
    init(pos : CGPoint,c : Card){
        self.pos = pos
        self.c = c
    }
}
class GameManagerPlayer{
    var playerDeck : [Card] = []
    var pTurn : Bool = true
    var pool : Card?
    var drawPile : Stack = Stack()
    var pStart : CGPoint = CGPoint()
    var pEnd : CGPoint = CGPoint()
    var poolP : CGPoint = CGPoint()
    var nxtzPos : Int =  0
    init(playerDeck:[Card],pTurn:Bool,pool:Card?,drawPile:Stack,pStart : CGPoint,pEnd : CGPoint,poolP : CGPoint){
        self.playerDeck = playerDeck
        self.pTurn = pTurn
        self.pool = pool
        self.drawPile = drawPile
        self.pStart = pStart
        self.poolP = poolP
        self.pEnd = pEnd
    }
    func updatezPos(zpos : Int){
        self.nxtzPos = zpos
    }
    func updatePool(c : Card?){
        pool = c
        
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
        if c.typ == .plus4 || c.typ == .swap{
            var clrs = [color:Int]()
            
            for var c : Card in playerDeck {
                if var i = clrs[c.clr]{
                    i+=1
                }else{
                    clrs[c.clr] = 1
                }
            
            }
            var m : Int = -1
            var clr : color = .none
            for (key,val) in clrs{
                m = max(m,val)
                if m == val{
                    clr = key
                }
            }
            c.clr = clr
        }
        var gr = GameRules(playerDeck:playerDeck,pool:pool)
        var pCards : [Card] = gr.getPlayableCards()
        var playable :Bool = false
        for var pc in pCards{
            if(pc.isEqual(c)){
                playable = true
            }
        }
        if(pTurn && playable){
            c.zPosition = CGFloat(nxtzPos)
           
            print("P:\(c.zPosition)")
            print("P:\(c.isHidden)")
            let neg = arc4random() % 2 == 0
            c.zRotation = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: Double.pi/6) * (neg ? -1 : 1))
            print(c.zRotation)
            removeFromHand(c:c)
         //   pTurn = false
        }
       
        print("Player zPos: \(nxtzPos)")
    }
    func draw()->DrawStruct?{
        var gr = GameRules(playerDeck:playerDeck,pool:pool)
        var pCards : [Card] = gr.getPlayableCards()
        var playable :Bool = false
        if(pTurn && drawPile.count > 0){
            let c = drawPile.pop()!

            var posX : Int = playerDeck.count == 0 ? Int(pStart.x) : Int(playerDeck[playerDeck.count-1].position.x),posY : Int = playerDeck.count == 0 ? Int(pStart.y) : Int(playerDeck[playerDeck.count-1].position.y)
            if posX + 80 > Int(pEnd.x){
                posX = Int(pStart.x);
                posY+=100
            }
           
            
            c.isHidden = false
            playerDeck.append(c)
            let ret =  DrawStruct(pos:CGPoint(x:posX+80,y:posY),c:c)
           
            return ret
        //    pTurn = false
        }
        return nil
    }
    func getPDeck()->[Card]{
        return playerDeck
    }
    func getPool()->Card?{
       return pool
    }
    func getDrawPile()->Stack{
        return drawPile
    }
}
