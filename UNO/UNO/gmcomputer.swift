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

class gmcomputer: GameScene{
    
    let regularCardChance: Int = 75
    let specialCardChance: Int = 25
    var cTurn: Bool = false
    
    func removFromHand(c: Card) {
        var index = 0
        while(index < computerDeck.count) {
            if c == computerDeck[index] {
                computerDeck.remove(at: index)
            }
        index += 1
        }
    }
    
    func playCard(c: Card) {
        if (cTurn) {
            pool.append(c)
            c.position.x = CGFloat(-Int(c.frame.height)/2 + 8)

            c.position.y = 0
            removFromHand(c : c)
        }
    }

    func draw() {
        if(cTurn) {
            //pop is a stack only function
            let c = pool[pool.count - 1]
            pool.removeLast()
            var posX: Int = Int(computerDeck[computerDeck.count-1].position.x)
            var posY: Int = Int(computerDeck[computerDeck.count-1].position.y)
            if posX + 80 > Int(self.frame.width)/2 {
                posX = -Int(self.frame.width)/2 + 80
                posY += 100
            }
            c.position.x = CGFloat(posX)
            c.position.y = CGFloat(posY)
            computerDeck.append(c)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
