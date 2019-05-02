//
//  RankingScene.swift
//  IOS_test
//
//  Created by Programacion Moviles on 2/5/19.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit
import GameplayKit
import FirebaseAnalytics

protocol RankingDelegate: class {
    func rankingToMenu(sender: RankingScene)
}

class RankingScene: SKScene, ButtonDelegate {
    
    weak var rankingDelegate: RankingDelegate?
    
    var backButton : Button?
    var points : SKLabelNode?
    var pointsLastGame = 0
    
    var highScoreLabel: SKLabelNode?
    var endGameLabel: SKLabelNode?
    var highScore: Int = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(named: "Fondo")!
        //ratios
        let widthRatio = frame.width / 2
        let heightRatio = widthRatio / 4.1
        
        FirestoreRepository().getUsetScore()
        //mostar los puntos de la partida
 
        self.endGameLabel = SKLabelNode(text: "RANKING")
        if let endGameLabel = self.endGameLabel{
            endGameLabel.fontColor = .red
            endGameLabel.verticalAlignmentMode = .center
            endGameLabel.fontSize = 25
            endGameLabel.fontName = "Futura"
            endGameLabel.position = CGPoint(x: (view.frame.width / 2), y: view.frame.height * 0.70)
            addChild(endGameLabel)
        }
        
        //boton para volver al menu inicial
        backButton = Button(rect: CGRect(x: 0, y: 0, width: widthRatio, height: heightRatio), cornerRadius: heightRatio / 2)
        if let backButton = backButton{
            backButton.strokeColor = .clear
            backButton.isUserInteractionEnabled = true;
            backButton.highlightColor = SKColor(named: "pressed")!
            backButton.delegate = self
            backButton.position = CGPoint(x: view.frame.width / 2.0 - backButton.frame.width/2, y: view.frame.height * 0.10)
            backButton.setText(text: "Main Menu")
            backButton.fillColor = SKColor(named: "notPressed")!
            addChild((backButton))
        }
    }
    
    func onTap(sender: Button) {
        if sender == backButton {
            rankingDelegate?.rankingToMenu(sender: self)
        }
    }
}
