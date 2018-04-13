//
//  GameViewController.swift
//  UNO
//
//  Created by Schlotman, Zachary J on 4/11/18.
//  Copyright © 2018 Schlotman,Grimshaw,Wall. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var currScene : SCNScene?
    override func viewDidLoad() {
        super.viewDidLoad()
        currScene = SCNScene()
        currScene?.background.contents = UIImage(named:"unologo2")
    }
    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
     
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
