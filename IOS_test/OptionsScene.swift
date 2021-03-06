//
//  OptionsScene.swift
//  IOS_test
//
//  Created by Programacion Moviles on 11/4/19.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit
import GameplayKit
import FirebaseAnalytics

protocol OptionsDelegate: class {
    func optionsToMenu(sender: OptionsScene)
}

class OptionsScene: SKScene, ButtonDelegate{
    var backButton : Button?
    var soundButton : Button?
    
    //var soundPressed: Bool = false
    
    weak var optionsDelegate: OptionsDelegate?
    var creditLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(named: "Fondo")!

        self.creditLabel = SKLabelNode(text: NSLocalizedString("   Game made by\nJoan Lopez Joaquin", comment: ""))
        if let creditLabel = self.creditLabel{
            creditLabel.fontColor = .red
            creditLabel.verticalAlignmentMode = .center
            creditLabel.fontSize = 20
            creditLabel.fontName = "Futura"
            creditLabel.numberOfLines = 2
            creditLabel.position = CGPoint(x: (view.frame.width / 2), y: view.frame.height * 0.70)
            addChild(creditLabel)
        }
        
        //back button
        let buttonWidth = view.frame.width / 6
        let buttonHeight = buttonWidth / 2.0
        
        backButton = Button(rect: CGRect(x: 0, y: 0 , width: buttonWidth, height: buttonHeight), cornerRadius: 10)
        if let backButton = backButton{
            backButton.setImage(imageNamed: "back", scale: 0.07)
            backButton.fillColor = .clear
            backButton.strokeColor = .clear
            backButton.isUserInteractionEnabled = true
            backButton.delegate = self
            backButton.position = CGPoint(x: view.frame.width / 9.0 - backButton.frame.width/2, y: view.frame.height * 0.9)
            addChild(backButton)
        }
        
        soundButton = Button(rect: CGRect(x: 0, y: 0 , width: buttonWidth, height: buttonHeight), cornerRadius: 10)
        if let soundButton = soundButton{
            soundButton.setImage(imageNamed: "sound", scale: 1.0)
            soundButton.fillColor = .clear
            soundButton.strokeColor = .clear
            soundButton.isUserInteractionEnabled = true
            soundButton.delegate = self
            soundButton.position = CGPoint(x: view.frame.width / 2 - (buttonWidth / 2), y: view.frame.height / 2)
            addChild(soundButton)
        }
    }
    
    
    func onTap(sender: Button) {
        if sender == backButton {
            optionsDelegate?.optionsToMenu(sender: self)
        }
        else if sender == soundButton{
            if AudioController.shared.soundPressed == false{
                soundButton?.setImage(imageNamed: "mute", scale: 1.0)
                AudioController.shared.off()
                Analytics.logEvent("gameMuted", parameters: [:])
                AudioController.shared.soundPressed = true
            }else if AudioController.shared.soundPressed == true{
                soundButton?.setImage(imageNamed: "sound", scale: 1.0)
                AudioController.shared.on()
                Analytics.logEvent("gameWithSound", parameters: [:])
                AudioController.shared.soundPressed = false
            }
        }
    }
}
