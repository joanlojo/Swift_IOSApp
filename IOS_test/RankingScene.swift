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
    var ranking = [String]()
    var rankingLabel : SKLabelNode?
    

    var goldMedal : SKSpriteNode?
    var silverMedal : SKSpriteNode?
    var bronzeMedal : SKSpriteNode?
    
    var pointsLastGame = 0
    
    var highScoreLabel: SKLabelNode?
    var endGameLabel: SKLabelNode?
    var highScore: String = ""
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(named: "Fondo")!
        //ratios
        let widthRatio = frame.width / 2
        let heightRatio = widthRatio / 4.1
        var count: Double = 0
        FirestoreRepository().getUsetScore { (datos, error) in
            for dato in datos?.reversed() ?? [] {
                count = count + 0.15
                self.highScore = dato
                self.highScoreLabel = SKLabelNode(text: self.highScore)
                if let highScoreLabel = self.highScoreLabel{
                    highScoreLabel.fontColor = .black
                    highScoreLabel.verticalAlignmentMode = .center
                    highScoreLabel.fontSize = 15
                    highScoreLabel.fontName = "Futura"
                    highScoreLabel.position = CGPoint(x: (view.frame.width / 2), y: (view.frame.height * CGFloat(count) + 100))
                    self.addChild(highScoreLabel)
                }
            }
            //mostrar la mejor puntuacion global desde firebase
         
        }
        
        //mostar los puntos de la partida
 
        self.endGameLabel = SKLabelNode(text: "RANKING")
        if let endGameLabel = self.endGameLabel{
            endGameLabel.fontColor = .red
            endGameLabel.verticalAlignmentMode = .center
            endGameLabel.fontSize = 30
            endGameLabel.fontName = "Futura"
            endGameLabel.position = CGPoint(x: (view.frame.width / 2), y: view.frame.height * 0.80)
            addChild(endGameLabel)
        }

        let iconGold = SKSpriteNode(imageNamed: "goldmedal")
        iconGold.position = CGPoint(x: (view.frame.width * 0.3 ), y: (view.frame.height * CGFloat(0.45) + 100))
        iconGold.setScale(1)
        addChild(iconGold)
        
        let iconSilver = SKSpriteNode(imageNamed: "silvermedal")
        iconSilver.position = CGPoint(x: (view.frame.width * 0.3), y: (view.frame.height * CGFloat(0.30) + 100))
        iconSilver.setScale(0.9)
        addChild(iconSilver)
        
        let iconBronze = SKSpriteNode(imageNamed: "bronzemedal")
        iconBronze.position = CGPoint(x: (view.frame.width * 0.3), y: (view.frame.height * CGFloat(0.15) + 100))
        iconBronze.setScale(0.8)
        addChild(iconBronze)
        
        
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
