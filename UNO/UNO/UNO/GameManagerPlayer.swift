import Foundation
import UIKit
class GameManagerPlayer{
    var playerDeck : [Card] = []
    var pTurn : Bool = true
    var pool : Card?
    var drawPile : Stack = Stack()
    var pStart : CGPoint = CGPoint()
    var pEnd : CGPoint = CGPoint()
    var poolP : CGPoint = CGPoint()
    init(playerDeck:[Card],pTurn:Bool,pool:Card?,drawPile:Stack,pStart : CGPoint,pEnd : CGPoint,poolP : CGPoint){
        self.playerDeck = playerDeck
        self.pTurn = pTurn
        self.pool = pool
        self.drawPile = drawPile
        self.pStart = pStart
        self.poolP = poolP
        self.pEnd = pEnd
    }
    func updatePool(c : Card){
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
        var gr = GameRules(playerDeck:playerDeck,pool:pool)
        var pCards : [Card] = gr.getPlayableCards()
        var playable :Bool = false
        for var pc in pCards{
            if(pc.isEqual(c)){
                playable = true
            }
        }
        if(pTurn && playable){
            
            c.position.x = poolP.x
            c.position.y = poolP.y
            let neg = arc4random() % 2 == 0
            c.zRotation = CGFloat(Double(arc4random()).truncatingRemainder(dividingBy: Double.pi/6) * (neg ? -1 : 1))
            print(c.zRotation)
            removeFromHand(c:c)
            //   pTurn = false
        }
        if let p = pool{
            c.zPosition = (p.zPosition)+1
        }
    }
    func draw(){
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
            c.position.x = CGFloat(posX+80)
            c.position.y = CGFloat(posY)
            c.isHidden = false
            playerDeck.append(c)
            //    pTurn = false
        }
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
