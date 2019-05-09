//
//  EndGameScene.swift
//  IOS_test
//
//  Created by Programacion Moviles on 8/4/19.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol EndGameDelegate: class {
    func resultToMenu(sender: EndGameScene)
}

class EndGameScene: SKScene, ButtonDelegate {
    
    weak var endGameDelegate: EndGameDelegate?
    
    var backButton : Button?
    var points : SKLabelNode?
    var pointsLastGame = 0
    
    let defaults = UserDefaults.standard
    //var scores = [String]
    
    var highScoreLabel: SKLabelNode?
    var endGameLabel: SKLabelNode?
    var highScore: Int = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(named: "Fondo")!
        //ratios
        let widthRatio = frame.width / 2
        let heightRatio = widthRatio / 4.1
        
        if let highScore = defaults.string(forKey: "Score") {
            if String(pointsLastGame) > highScore {
                 defaults.set(String(pointsLastGame), forKey: "Score")
            }
            self.highScoreLabel = SKLabelNode(text: "High Score: " + String(highScore))
            if let highScoreLabel = self.highScoreLabel {
                highScoreLabel.fontColor = .black
                highScoreLabel.verticalAlignmentMode = .center
                highScoreLabel.fontSize = 18
                highScoreLabel.fontName = "Futura"
                highScoreLabel.position = CGPoint(x: (view.frame.width / 2), y: view.frame.height * 0.40)
                addChild(highScoreLabel)
            }
        }
       
        //mostar los puntos de la partida
        self.points = SKLabelNode(text: "Points: " + String(pointsLastGame))
        if let points = self.points {
            points.fontColor = .black
            points.verticalAlignmentMode = .center
            points.fontSize = 18
            points.fontName = "Futura"
            points.position = CGPoint(x: (view.frame.width / 2), y: view.frame.height/2)
            addChild(points)
        }
        //mostrar el high score, demomento no esta la logica
       
       
        self.endGameLabel = SKLabelNode(text: "You have finished the game!")
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
            endGameDelegate?.resultToMenu(sender: self)
        }
    }
}
