import Foundation

class GameRules {
    var playerDeck : [Card] = []
    var playableCards : [Card] = []
    var pool : Card?
    init(playerDeck : [Card],pool : Card?){
        self.playerDeck = playerDeck
        self.pool = pool
        canPlay()
    }
    func update(playerDeck : [Card],pool : Card?){
        playableCards = []
        self.playerDeck = playerDeck
        self.pool = pool
        canPlay()
        
    }
    
    //10 skip
    //11 reverse
    //12 +2
    
    func rules(previousCard: Card, cards: Card) -> Bool {
        if cards.num == previousCard.num || cards.clr == previousCard.clr {
            if cards.num == 10 {
                //skipPlayer
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
            return true
        } else {
        
        if cards.typ == .plus4 {
            //changeColor()
            //draw(4)
            return true
        }
        
        if cards.typ == .swap {
            //changeColor()
            return true
        }
            
        }
        return false
    }
    
    func canPlay() {
            if let previousCard = pool{
            for cards in playerDeck {
                if rules(previousCard: previousCard, cards: cards) {
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
