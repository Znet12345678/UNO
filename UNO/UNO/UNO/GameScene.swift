import SpriteKit
import GameplayKit


class GameScene: SKScene {
    var pTurn : Bool = true
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var cpus : Int?
    var gr : GameRules?
    var poolMov : Card?
    var handMov : Card?
    var moveFinished : Bool = true
    var handMovPos : CGPoint?
    var gmcomp :[gmcomputer] = []
    var zPos : Int = 0
    var canTouch : Bool = true
    var left : Bool = true
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
    var computerDeck:[[Card]] = []
    var gmPlyr :GameManagerPlayer?
    //creates a LIFO structure
    //players play their card and place here
    var pool : Card?
    var rot : Double = Double.pi/7
    var tsB : Bool = true
    let initxDistance: Int = 80
    var separation: Int = 80
    //players draw cards from
    var drawPile : Stack = Stack()
    //NOTE THIS IS NOT GOING TO STAY
    //all Cards initalized here (IK hard code is bad but i get nullPointer issues. If you figure a better way thats great)
    //red
    func shuffle( deck: [Card])-> [Card]{
        var i = deck.count-1
        var d = deck
        while(i >= 1){
            
            let r = Int(arc4random()) % (i)
            let sv : Card = d[i]
            d[i] = d[r]
            d[r] = sv
            
            i-=1
        }
        return d
    }
    
    
    
    
    var iDeck : [Card] = []
    var iDecks  = Stack()
    var pStart :SKSpriteNode?,cStart : SKSpriteNode?, pEnd :SKSpriteNode?,cEnd:SKSpriteNode?,poolStart : SKSpriteNode?
    var deck : SKSpriteNode?
    //takes all cards and assigns a location for them
    func fillDecks()
    {
        print(cpus)
        //drawPile.push(CARD) adds the card to the stack
        //CARD.position gives a location for the touchesMoved method to use for testing the drawing and rearranging of cards logic
        //addChild(CARD) activates the node to be used by the game handler
        NSLog("Filling deck")
        for var child :  SKNode in self.children{
            if child.name == "Deck"{
                deck = child as? SKSpriteNode
            }
            if child.name == "Player 1"{
                pStart = child as? SKSpriteNode
            }
            if child.name == "Player 2"{
                cStart = child as? SKSpriteNode
            }
            if child.name == "Player 3"{
                pEnd = child as? SKSpriteNode
            }
            if child.name == "Player 4"{
                cEnd = child as? SKSpriteNode
            }
            if child.name == "PoolPile"{
                poolStart = child as? SKSpriteNode
            }
        }
        
        var i = 0
        while(i < 11){
            iDeck.append(Card(clr:.red,typ:.normal,num:i))
            iDeck.append(Card(clr:.yellow,typ:.normal,num:i))
            iDeck.append(Card(clr:.blue,typ:.normal,num:i))
            iDeck.append(Card(clr:.green,typ:.normal,num:i))
            i+=1
        }
        
        iDeck = shuffle(deck:iDeck)
        var x = Int((pStart?.position.x)!)
        var y = Int((pStart?.position.y)!)
        for var c : Card in iDeck{
            c.position = CGPoint(x:(deck?.position.x)!,y:(deck?.position.y)!)
            addChild(c)
        }
        for var c : Card in iDeck{
            iDecks.push(c)
        }
        i = 0
        for j in 0 ... cpus!{
            computerDeck.append([])
        }
        while(i < 7){
            playerDeck.append(iDecks.pop()!)
            playerDeck[playerDeck.count-1].position = CGPoint(x:x,y:y)
            for j in 0 ... cpus!{
                computerDeck[j].append(iDecks.pop()!)
                computerDeck[j][computerDeck[j].count-1].isHidden = true
            }
            if x <= 295 {
                x += initxDistance
            } else {
                x = Int((pStart?.position.x)!)
                y += 25
            }
            i+=1
        }
        while(iDecks.count > 0){
            drawPile.push(iDecks.pop()!)
        }
        for i in 0 ... cpus!{
            
            gmcomp.append(gmcomputer(pool: pool, computerDeck: computerDeck[i], cBegin: (cStart?.position)!, cEnd: (cEnd?.position)! , poolP: (poolStart?.position)!, drawPile: drawPile))
            
        }
        gmPlyr = GameManagerPlayer(playerDeck: playerDeck, pTurn: pTurn, pool: pool, drawPile: drawPile, pStart:(pStart?.position)!, pEnd: (pEnd?.position)!,poolP:(poolStart?.position)!)
        
        
        //divide into intial groups of cards
        /*i = 1
         while i <= 10 {
         playerDraw()
         var k = 0
         while(k < cpus){
         computerDraw(cpu:k)
         k+=1
         }
         i += 1
         }*/
        gr = GameRules(playerDeck: playerDeck, pool: pool)
    }
    //player takes a card from the draw pile
    func playerDraw()
    {
        print(drawPile.count)
        playerDeck.append(drawPile.pop()!)
    }
    //computer takes a card from the draw pile
    func computerDraw(cpu : Int)
    {
        print(drawPile.count)
        computerDeck[cpu].append(drawPile.pop()!)
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
            
            
            if tsB{
                tsB = false
                self.view?.presentScene(SKScene(fileNamed:"TitleScene"))
                return
            }
            
            fillDecks()
            gameStarted = true
        }
       /* if pTurn == true
        {
            print("It is now the player's turn")
        } */
        if let hc = handMov{
            
            hc.position = CGPoint(x:abs(hc.position.x - (handMovPos?.x)!) > 5 ? hc.position.x + (hc.position.x >= (handMovPos?.x)! ? -5 : 5) : hc.position.x,y:abs(hc.position.y - (handMovPos?.y)!) <= 5 ? CGFloat(hc.position.y) : hc.position.y + (hc.position.y >= (handMovPos?.y)! ? -5 : 5))
            if abs(hc.position.x - (handMovPos?.x)!) <= 5 && abs(hc.position.y - (handMovPos?.y)!) <= 5{
                handMov = nil
                handMovPos = nil
                for i in 0 ... cpus!{
                    
                    gmcomp[i].updatezPos(zpos:zPos)
                    gmcomp[i].updatePool(c: pool)
                    gmcomp[i].act()
                    print("Act")
                    pool = gmcomp[i].getPool()
                    sleep(1)
                    zPos+=1
                }
            }
        }
        if let c = poolMov{
            
            c.position = CGPoint(x:(abs(c.position.x - (poolStart?.position.x)!) > 5) ? c.position.x + ((c.position.x >= (poolStart?.position.x)! ? -5 : 5)) : c.position.x,y:abs(c.position.y - (poolStart?.position.y)!) <= 5 ? c.position.y : c.position.y + (c.position.y >= (poolStart?.position.y)! ? -5 : 5))
            
            if abs(c.position.x - (poolStart?.position.x)!) <= 5 && abs(c.position.y - (poolStart?.position.y)!) <= 5 {
                poolMov = nil
                for i in 0 ... cpus!{
                    gmcomp[i].updatezPos(zpos: zPos)
                    gmcomp[i].updatePool(c:pool)
                    gmcomp[i].act()
                    
                    print("Act")
                    
                    pool = gmcomp[i].getPool()
                    sleep(1)
                    zPos+=1
                }
            }
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
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.green
         self.addChild(n)
         }*/
        pTurn = false
        while(!pTurn){
            for i in 0 ... cpus!{
                
                pTurn = gmcomp[i].doneF()
                if pTurn{
                    break
                }
            }
        }
        print("Pool zPos: \(pool?.zPosition)")
        if(pTurn){
            zPos+=1
            
            pool = gmcomp[gmcomp.count-1].getPool()
            
            gmPlyr?.updatePool(c: pool)
            gmPlyr?.updatezPos(zpos: zPos)
            for i in 0 ... cpus!{
                gmcomp[i].updatezPos(zpos: zPos)
            }
            if(Int(pos.y) < -37){
                for var c in playerDeck{
                    if(abs(c.position.x-pos.x) <= 50 && abs(c.position.y-pos.y) <= 75){
                        print("Trying to play card \(c)")
                        var canPlay : Bool = false
                        gr = GameRules(playerDeck: playerDeck, pool: pool)
                        print("\(playerDeck)<-playerDeck ____ playableCards-> \(gr?.getPlayableCards())")
                        for var pc in (gr?.getPlayableCards())!{
                            if pc.isEqual(c){
                                canPlay = true
                            }
                        }
                        if canPlay{
                            gmPlyr?.PlayCard(c: c)
                            moveFinished = false
                            playerDeck = (gmPlyr?.getPDeck())!
                            let r : Int = drawPile.count <= 1 ? 0 : Int(arc4random())%(drawPile.count-1)
                            if let dup = pool{
                                dup.isHidden = false
                                drawPile.insert(c: dup, indx: r)
                            }
                            //     pool?.isHidden = true
                            
                            pool = c
                            poolMov = pool
                            drawPile = (gmPlyr?.getDrawPile())!
                            zPos+=1
                            
                            
                            for var i in playerDeck {
                                if i.position.x < c.position.x {
                                    i.position.x += CGFloat(40)
                                } else {
                                    i.position.x -= CGFloat(40)
                                }
                            }
                        }else{
                            return;
                        }
                        
                    }
                }
            }else if(pos.y <= 37 && pos.y >= -37) && (pos.x <= 25 &&  pos.x >= -25){
                let drawS :DrawStruct? = gmPlyr?.draw()
                playerDeck = (gmPlyr?.getPDeck())!
                pool = gmPlyr?.getPool()
                drawPile = (gmPlyr?.getDrawPile())!
                if let ds = drawS{
                    
                    handMov = ds.c
                    handMovPos = ds.pos
                }
                
            }
            /*
             gmcomp?.updatezPos(zpos: zPos)
             gmcomp?.updatePool(c: pool)*/
            pTurn = false
            /*
             pool = gmcomp?.getPool()
             */
            gr?.update(playerDeck: playerDeck, pool: pool)
            gmPlyr?.updatePool(c: pool)
        }
    }
    func touchMoved(toPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.blue
         self.addChild(n)
         }*/
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.red
         self.addChild(n)
         }*/
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if canTouch{
            for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            //self.touchMoved(toPoint: t.location(in: self))
            
            //Code to allow cards to be moved and rearranged by the player
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
    
    
}
