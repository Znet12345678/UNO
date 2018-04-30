//
//  TitleScene.swift
//  UNO
//
//  Created by Grimshaw, Steven K on 4/24/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

import SpriteKit
import GameplayKit

class TitleScene: SKScene {

    var oneCPUButton: SKSpriteNode!
    var twoCPUButton: SKSpriteNode!
    var threeCPUButton: SKSpriteNode!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        for var sn: SKNode in self.children {
            if sn.name == "oneCPUButton" {
                print("Found")
                oneCPUButton = sn as! SKSpriteNode
                twoCPUButton = sn as! SKSpriteNode
                threeCPUButton = sn as! SKSpriteNode
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
        if abs((oneCPUButton.position.x - pos.x)) <= oneCPUButton.size.width && abs((oneCPUButton.position.y - pos.y)) <= oneCPUButton.size.height {
            print("1 opponent selected")
            goToScene(scene:SKScene(fileNamed: "GameScene") as! GameScene)
        }
        if abs((twoCPUButton.position.x - pos.x)) <= twoCPUButton.size.width && abs((twoCPUButton.position.y - pos.y)) <= twoCPUButton.size.height {
            print("2 opponent selected")
            goToScene(scene:SKScene(fileNamed: "GameScene") as! GameScene)
        }
        if abs((twoCPUButton.position.x - pos.x)) <= twoCPUButton.size.width && abs((twoCPUButton.position.y - pos.y)) <= twoCPUButton.size.height {
            print("3 opponent selected")
            goToScene(scene:SKScene(fileNamed: "GameScene") as! GameScene)
        }
 
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    
    
}




