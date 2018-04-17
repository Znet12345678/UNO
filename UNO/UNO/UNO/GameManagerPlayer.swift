//
//  GameManagerPlayer.swift
//  UNO
//
//  Created by Schlotman, Zachary J on 4/17/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import Foundation
import UIKit
struct Stack {
    //make the array properties part of stack, use.array for array functionality
    fileprivate var array: [Card] = []
    var count : Int = 0
    //addcards to the last position of the array
    mutating func push(_ element:Card)
    {
        array.append(element)
        count+=1
    }
    //take the last card from the array removing it and returning it
    mutating func pop() -> Card?
    {
        count-=1
        return array.popLast()
    }
    //returns the last card in the array
    func peek() -> Card? {
        return array.last
    }
}
class GameManagerPlayer{
    func removeFromHand(c : Card,playerDeck : [Card]){
        var indx = 0
        while(indx < playerDeck.count){
            if(c == playerDeck[indx]){
                playerDeck.remove(at: indx)
            }
            indx+=1
        }
    }
    func PlayCard(c : Card, frame : CGRect,pool : Card){
        if(pTurn){
            pool.append(c)
            c.position.x = CGFloat(-Int(frame.height)/2+8+0)
            c.position.y = 0
            removeFromHand(c:c)
         //   pTurn = false
        }
    }
    func draw(){
        if(pTurn){
            print(drawPile.count)
            let c = drawPile.pop()!
            var posX : Int = Int(playerDeck[playerDeck.count-1].position.x),posY : Int = Int(playerDeck[playerDeck.count-1].position.y)
            if posX + 80 > Int(self.frame.width)/2{
                posX = -Int(self.frame.width)/2+80;
                posY+=100
            }
            c.position.x = CGFloat(posX)
            c.position.y = CGFloat(posY)
            playerDeck.append(c)
        //    pTurn = false
        }
    }
}
