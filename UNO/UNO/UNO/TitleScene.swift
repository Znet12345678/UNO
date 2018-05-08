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
                
            }
            if sn.name == "twoCPUButton"{
                twoCPUButton = sn as! SKSpriteNode
            }
            
        }
    }
    
    func goToScene(scene: SKScene,cpus : Int) {
        var gs : GameScene? = scene as? GameScene
        gs?.tsB = false
        gs?.cpus = cpus
        let sceneTransition = SKTransition.fade(with: .darkGray, duration: 0.5)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: sceneTransition)
    }
    
    func getNextScene() -> SKScene? {
        return SKScene(fileNamed: "GameScene")
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("touches ran")
        if abs((oneCPUButton.position.x - pos.x)) <= oneCPUButton.size.width && abs((oneCPUButton.position.y - pos.y)) <= oneCPUButton.size.height {
            print("1 opponent selected")
            goToScene(scene:SKScene(fileNamed: "GameScene") as! GameScene,cpus:0)
        }
        if abs((twoCPUButton.position.x - pos.x)) <= twoCPUButton.size.width && abs((twoCPUButton.position.y - pos.y)) <= twoCPUButton.size.height {
            print("2 opponent selected")
            goToScene(scene:SKScene(fileNamed: "GameScene") as! GameScene,cpus:1)
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    
    
}
