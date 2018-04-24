import Foundation

class Opponent : gmcomputer {
    
    //should be ran within an if statement determining if their is a usable card
    //I reused the isUsable method in the method just to single out the usable cards
    func chooseRandomCard(regProb: Int, specProb: Int) {

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
    
}
