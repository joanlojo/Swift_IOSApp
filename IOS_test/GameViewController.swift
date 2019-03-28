//
//  GameViewController.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 15/02/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, GameSceneDelegate, MenuSceneDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MenuScene(size:view.frame.size)
            scene.menuSceneDelegate = self
            
            //if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
                // Present the scene
            view.presentScene(scene)
            //}
            
            //view.ignoresSiblingOrder = true //aumenta la performance de muchos nodos, no utilizar
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return false //false si no se rota en las dos direcciones
    }

    override var supportedInterfaceOrientations:
        UIInterfaceOrientationMask{
            return .portrait //si el juego es en portrait
        }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func goToGame(sender: MenuScene, difficulty: Difficulty) {
        if let view = self.view as? SKView {
            let scene = GameScene(size: view.frame.size)
            scene.difficulty = difficulty
            scene.gameSceneDelegate = self
            scene.backgroundColor = SKColor(named: "Fondo")!
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }

    }
    
    func goToSettings(sender: MenuScene) {
        
    }

    func goToAbout(sender: MenuScene) {

    }

    func back(sender: GameScene) {
        if let view = self.view as? SKView {
            let scene = MenuScene(size: view.frame.size)
            scene.menuSceneDelegate = self
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
}
