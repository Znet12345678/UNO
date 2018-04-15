//
//  GameScene.swift
//  UNO
//
//  Created by Wall, Nicholas E on 4/5/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    
    
    //whos turn 1:player 2:cpu
    var currentTurn:Int = 1
    //is game running
    var gameStarted:Bool = false
    //determine who won
    var playerWin:Bool = false
    var computerWin:Bool = false
    //player's cards
    var playerDeck:[Card] = []
    //computer's cards
    var computerDeck:[Card] = []
    //creates a LIFO structure
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
    //players play their card and place here
    var pool : [Card] = []
    //players draw cards from
    var drawPile : [Card] = []
    //NOTE THIS IS NOT GOING TO STAY
    
    //all Cards initalized here (IK hard code is bad but i get nullPointer issues. If you figure a better way thats great)
        //red
        /*let red1 = Card(clr: .red, typ: .normal, num: 1)
        let red2 = Card(clr: .red, typ: .normal, num: 2)
        let red3 = Card(clr: .red, typ: .normal, num: 3)
        let red4 = Card(clr: .red, typ: .normal, num: 4)
        let red5 = Card(clr: .red, typ: .normal, num: 5)
        let red6 = Card(clr: .red, typ: .normal, num: 6)
        let red7 = Card(clr: .red, typ: .normal, num: 7)
        let red8 = Card(clr: .red, typ: .normal, num: 8)
        let red9 = Card(clr: .red, typ: .normal, num: 9)
        let red10 = Card(clr: .red, typ: .normal, num: 10)
        //green
        let green1 = Card(clr: .red, typ: .normal, num: 1)
        let green2 = Card(clr: .red, typ: .normal, num: 2)
        let green3 = Card(clr: .red, typ: .normal, num: 3)
        let green4 = Card(clr: .red, typ: .normal, num: 4)
        let green5 = Card(clr: .red, typ: .normal, num: 5)
        let green6 = Card(clr: .red, typ: .normal, num: 6)
        let green7 = Card(clr: .red, typ: .normal, num: 7)
        let green8 = Card(clr: .red, typ: .normal, num: 8)
        let green9 = Card(clr: .red, typ: .normal, num: 9)
        let green10 = Card(clr: .red, typ: .normal, num: 10)
        //blue
        let blue1 = Card(clr: .red, typ: .normal, num: 1)
        let blue2 = Card(clr: .red, typ: .normal, num: 2)
        let blue3 = Card(clr: .red, typ: .normal, num: 3)
        let blue4 = Card(clr: .red, typ: .normal, num: 4)
        let blue5 = Card(clr: .red, typ: .normal, num: 5)
        let blue6 = Card(clr: .red, typ: .normal, num: 6)
        let blue7 = Card(clr: .red, typ: .normal, num: 7)
        let blue8 = Card(clr: .red, typ: .normal, num: 8)
        let blue9 = Card(clr: .red, typ: .normal, num: 9)
        let blue10 = Card(clr: .red, typ: .normal, num: 10)
        //yellow
        let yellow1 = Card(clr: .red, typ: .normal, num: 1)
        let yellow2 = Card(clr: .red, typ: .normal, num: 2)
        let yellow3 = Card(clr: .red, typ: .normal, num: 3)
        let yellow4 = Card(clr: .red, typ: .normal, num: 4)
        let yellow5 = Card(clr: .red, typ: .normal, num: 5)
        let yellow6 = Card(clr: .red, typ: .normal, num: 6)
        let yellow7 = Card(clr: .red, typ: .normal, num: 7)
        let yellow8 = Card(clr: .red, typ: .normal, num: 8)
        let yellow9 = Card(clr: .red, typ: .normal, num: 9)
        let yellow10 = Card(clr: .red, typ: .normal, num: 10)
    
        */
    func shuffle( deck: [Card])-> [Card]{
        var i = deck.count-1
        var d = deck
        while(i >= 1){

            let r = Int(arc4random()) % (i)
            let sv : Card = deck[i]
            d[i] = deck[r]
            d[r] = sv
            
            i-=1
        }
        return d
    }
    var iDeck : [Card] = []
    var iDecks  = Stack()
    //takes all cards and assigns a location for them
    func fillDecks()
    {
        //drawPile.push(CARD) adds the card to the stack
        //CARD.position gives a location for the touchesMoved method to use for testing the drawing and rearranging of cards logic
        //addChild(CARD) activates the node to be used by the game handler
        
        //NOTE @CARDS(BLUE & YELLOW STILL NEED TEMPORARY POSITIONS)
        var i = 0
        while(i < 11){
            iDeck.append(Card(clr:.red,typ:.normal,num:i))
            iDeck.append(Card(clr:.yellow,typ:.normal,num:i))
            iDeck.append(Card(clr:.blue,typ:.normal,num:i))
            iDeck.append(Card(clr:.green,typ:.normal,num:i))
            i+=1
        }
        iDeck = shuffle(deck : iDeck)
        for var c : Card in iDeck{
            iDecks.push(c)
        }
        i = 0
        while(i < 7){
            playerDeck.append(iDecks.pop()!)
            computerDeck.append(iDecks.pop()!)
            i+=1
        }
        while(iDecks.count > 0){
            drawPile.append(iDecks.pop()!)
        }
        /*drawPile.push(red1)
        red1.position = CGPoint(x: 100, y: 200)
        addChild(red1)
        drawPile.push(red2)
        red2.position = CGPoint(x: 100, y: 200)
        addChild(red2)
        drawPile.push(red3)
        red3.position = CGPoint(x: 100, y: 200)
        addChild(red3)
        drawPile.push(red4)
        red4.position = CGPoint(x: 100, y: 200)
        addChild(red4)
        drawPile.push(red5)
        red5.position = CGPoint(x: 100, y: 200)
        addChild(red5)
        drawPile.push(red6)
        red6.position = CGPoint(x: 100, y: 200)
        addChild(red6)
        drawPile.push(red7)
        red7.position = CGPoint(x: 100, y: 200)
        addChild(red7)
        drawPile.push(red8)
        red8.position = CGPoint(x: 100, y: 200)
        addChild(red8)
        drawPile.push(red9)
        red9.position = CGPoint(x: 100, y: 200)
        addChild(red9)
        drawPile.push(red10)
        red10.position = CGPoint(x: 100, y: 200)
        addChild(red10)
        //green
        drawPile.push(green1)
        green1.position = CGPoint(x: 100, y: 200)
        addChild(green1)
        drawPile.push(green2)
        green2.position = CGPoint(x: 100, y: 200)
        addChild(green2)
        drawPile.push(green3)
        green3.position = CGPoint(x: 100, y: 200)
        addChild(green3)
        drawPile.push(green4)
        green4.position = CGPoint(x: 100, y: 200)
        addChild(green4)
        drawPile.push(green5)
        green5.position = CGPoint(x: 100, y: 200)
        addChild(green5)
        drawPile.push(green6)
        green6.position = CGPoint(x: 100, y: 200)
        addChild(green6)
        drawPile.push(green7)
        green7.position = CGPoint(x: 100, y: 200)
        addChild(green7)
        drawPile.push(green8)
        green8.position = CGPoint(x: 100, y: 200)
        addChild(green8)
        drawPile.push(green9)
        green9.position = CGPoint(x: 100, y: 200)
        addChild(green9)
        drawPile.push(green10)
        green10.position = CGPoint(x: 100, y: 200)
        addChild(green10)
        //blue
        drawPile.push(blue1)
        addChild(blue1)
        drawPile.push(blue2)
        addChild(blue2)
        drawPile.push(blue3)
        addChild(blue3)
        drawPile.push(blue4)
        addChild(blue4)
        drawPile.push(blue5)
        addChild(blue5)
        drawPile.push(blue6)
        addChild(blue6)
        drawPile.push(blue7)
        addChild(blue7)
        drawPile.push(blue8)
        addChild(blue8)
        drawPile.push(blue9)
        addChild(blue9)
        drawPile.push(blue10)
        addChild(blue10)
        //yellow
        drawPile.push(yellow1)
        addChild(yellow1)
        drawPile.push(yellow2)
        addChild(yellow2)
        drawPile.push(yellow3)
        addChild(yellow3)
        drawPile.push(yellow4)
        addChild(yellow4)
        drawPile.push(yellow5)
        addChild(yellow5)
        drawPile.push(yellow6)
        addChild(yellow6)
        drawPile.push(yellow7)
        addChild(yellow7)
        drawPile.push(yellow8)
        addChild(yellow8)
        drawPile.push(yellow9)
        addChild(yellow9)
        drawPile.push(yellow10)
        addChild(yellow10)*/
        
        //divide into intial groups of cards
        i = 1
        while i <= 10 {
            playerDraw()
            computerDraw()
            i += 1
        }
    }
    //player takes a card from the draw pile
    func playerDraw()
    {
        playerDeck.append(drawPile[drawPile.count-1])
        drawPile.remove(at: drawPile.count-1)
    }
    //computer takes a card from the draw pile
    func computerDraw()
    {
        computerDeck.append(drawPile[drawPile.count-1])
        drawPile.remove(at: drawPile.count-1)
    }
    //checks to see if either the player or cpu has meet the parameters to win
    func checkDeckSize()
    {
        if playerDeck.count == 0
        {
            playerWin = true
        }
        else if computerDeck.count == 0
        {
            computerWin = true
        }
    }
   
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if gameStarted == false
        {
            
            fillDecks()
            gameStarted = true
        }
        //label?.text = "\(playerDeck.count)"
        checkDeckSize()
        //if 1 then it is the player's turn
        if currentTurn == 1
        {
            //logic for player placing a card and then changing the turn counter to 1
        }
        else
        {
            //logic for the computer placing a card and then changing the turn counter to 2
        }
    }
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        //self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        //if let label = self.label {
         //   label.alpha = 0.0
          //  label.run(SKAction.fadeIn(withDuration: 2.0))
            //label.text = "\(playerDeck.count)"
            
            
        
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //self.touchMoved(toPoint: t.location(in: self))
            
            //Code to allow cards to be moved and rearranged by the player
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                card.position = location
            }
        
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
   
    
    
    
}
