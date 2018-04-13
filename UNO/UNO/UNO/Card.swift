//
//  Card.swift
//  UNO
//
//  Created by Wall, Nicholas E on 4/5/18.
//  Copyright © 2018 Wall, Nicholas E. All rights reserved.
//

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
            switch typ {
            case .normal:
                switch clr {
                case .red:
                    switch num {
                    case 1:
                        frontTexture = SKTexture(imageNamed: "unocard_red_1")
                    case 2:
                        frontTexture = SKTexture(imageNamed: "unocard_red_2")
                    case 3:
                        frontTexture = SKTexture(imageNamed: "unocard_red_3")
                    case 4:
                        frontTexture = SKTexture(imageNamed: "unocard_red_4")
                    case 5:
                        frontTexture = SKTexture(imageNamed: "unocard_red_5")
                    case 6:
                        frontTexture = SKTexture(imageNamed: "unocard_red_6")
                    case 7:
                        frontTexture = SKTexture(imageNamed: "unocard_red_7")
                    case 8:
                        frontTexture = SKTexture(imageNamed: "unocard_red_8")
                    case 9:
                        frontTexture = SKTexture(imageNamed: "unocard_red_9")
                    case 10:
                        frontTexture = SKTexture(imageNamed: "unocard_red_10")
                    default:
                        frontTexture = SKTexture(imageNamed: "unocard_front")
                    }
                
                case .green:
                    switch num {
                    case 1:
                        frontTexture = SKTexture(imageNamed: "unocard_green_1")
                    case 2:
                        frontTexture = SKTexture(imageNamed: "unocard_green_2")
                    case 3:
                        frontTexture = SKTexture(imageNamed: "unocard_green_3")
                    case 4:
                        frontTexture = SKTexture(imageNamed: "unocard_green_4")
                    case 5:
                        frontTexture = SKTexture(imageNamed: "unocard_green_5")
                    case 6:
                        frontTexture = SKTexture(imageNamed: "unocard_green_6")
                    case 7:
                        frontTexture = SKTexture(imageNamed: "unocard_green_7")
                    case 8:
                        frontTexture = SKTexture(imageNamed: "unocard_green_8")
                    case 9:
                        frontTexture = SKTexture(imageNamed: "unocard_green_9")
                    case 10:
                        frontTexture = SKTexture(imageNamed: "unocard_green_10")
                    default:
                        frontTexture = SKTexture(imageNamed: "unocard_front")
                    }
                case .blue:
                    switch num {
                    case 1:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_1")
                    case 2:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_2")
                    case 3:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_3")
                    case 4:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_4")
                    case 5:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_5")
                    case 6:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_6")
                    case 7:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_7")
                    case 8:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_8")
                    case 9:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_9")
                    case 10:
                        frontTexture = SKTexture(imageNamed: "unocard_blue_10")
                    default:
                        frontTexture = SKTexture(imageNamed: "unocard_front")
                    }

                case .yellow:
                    switch num {
                    case 1:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_1")
                    case 2:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_2")
                    case 3:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_3")
                    case 4:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_4")
                    case 5:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_5")
                    case 6:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_6")
                    case 7:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_7")
                    case 8:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_8")
                    case 9:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_9")
                    case 10:
                        frontTexture = SKTexture(imageNamed: "unocard_yellow_10")
                    default:
                        frontTexture = SKTexture(imageNamed: "unocard_front")
                    }
                
                default:
                    frontTexture = SKTexture(imageNamed: "unocard_front")
                }
            case .plus4:
                frontTexture = SKTexture(imageNamed: "unocard_14")
            case .swap:
                frontTexture = SKTexture(imageNamed: "unocard_13")
            default:
                frontTexture = SKTexture(imageNamed: "unocard_front")
            }
            
            super.init(texture: frontTexture, color: .clear,size: frontTexture.size())
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
        
    }

