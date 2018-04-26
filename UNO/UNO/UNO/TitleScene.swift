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

    var oneCPUButon:SKSpriteNode!
    var twoCPUButton:SKSpriteNode!
    var threeCPUButton:SKSpriteNode!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        oneCPUButon = childNode(withName: "oneCPUButton") as! SKSpriteNode
        twoCPUButton = childNode(withName: "twoCPUButton") as! SKSpriteNode
        threeCPUButton = childNode(withName: "threeCPUButton") as! SKSpriteNode
    }
    
    func goToScene(scene: SKScene) {
        let sceneTransition = SKTransition.fade(with: .darkGray, duration: 0.5)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: sceneTransition)
    }
    
    func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "GameScene") as! GameScene
    }
    
    
    // touches are not being registered
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
        let touchLocation = t.location(in: self)
        
        print(touchLocation)
            if oneCPUButon.contains(touchLocation) {
                print("1 opponent selected")
                goToScene(scene:SKScene(fileNamed: "GameScene") as! GameScene)
            }
            else if twoCPUButton.contains(touchLocation) {
                goToScene(scene: getNextScene()!)
                print("2 opponents selected")
            }
            else if threeCPUButton.contains(touchLocation) {
                goToScene(scene: getNextScene()!)
                print("3 opponents selected")
            }
        }
        
        }
    }
    
       


