//
//  GameOver.swift
//  UNO
//
//  Created by Grimshaw, Steven K on 4/26/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver : SKScene {

    var homeButton: SKSpriteNode!
   
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        // twoCPUButton = childNode(withName: "twoCPUButton") as? SKSpriteNode
        //threeCPUButton = childNode(withName: "threeCPUButton") as? SKSpriteNode
        for var sn: SKNode in self.children {
            if sn.name == "homeButton" {
                print("Found")
                homeButton = sn as! SKSpriteNode
            }
        }
    }
    
    func goToScene(scene: SKScene) {
        let sceneTransition = SKTransition.fade(with: .darkGray, duration: 0.5)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: sceneTransition)
    }
    
    func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "GameScene") as! GameScene
    }
    
    // function isnt running
    func touchDown(atPoint pos : CGPoint) {
        print("touches ran")
        if abs((homeButton.position.x - pos.x)) <= homeButton.size.width && abs((homeButton.position.y - pos.y)) <= homeButton.size.height {
            print("1 opponent selected")
            goToScene(scene:SKScene(fileNamed: "TitleScene") as! TitleScene)
        }
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    


}
