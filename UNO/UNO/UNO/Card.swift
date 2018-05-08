import SpriteKit

enum type {
    case normal
    case swap
    case plus4
}

enum color {
    case red
    case green
    case yellow
    case blue
    case none
}

class Card : SKSpriteNode {
    let clr: color
    let typ: type
    let num: Int
    let frontTexture: SKTexture
    let backTexture: SKTexture
    
    
    init(clr: color, typ: type, num: Int) {
        self.clr = clr
        self.typ = typ
        self.num = num
        backTexture = SKTexture(imageNamed: "unocard_front")
        var color = String()
        switch(clr){
        case .red:
            color = "red"
        case .yellow:
            color = "yellow"
        case .green:
            color = "green"
        case .blue:
            color = "blue"
        case .none:
            color = ""
        }
        if(typ == .normal){
            frontTexture = SKTexture(imageNamed: "unocard_\(color)_\(num)")
        }else{
            frontTexture = SKTexture(imageNamed:"unocard_\(num)")
        }
        super.init(texture: frontTexture, color: .clear,size: frontTexture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let cObject = object as? Card{
            return cObject.clr == self.clr && cObject.num == self.num
        }
        return false
    }
    
    
}
