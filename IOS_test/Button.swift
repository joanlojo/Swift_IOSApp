//
//  Button.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 07/03/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit

protocol ButtonDelegate: class {
    func onTap(sender: Button)
}

class Button: SKShapeNode {
    
    weak var delegate: ButtonDelegate?
    private let textNode = SKLabelNode()
    private var icon: SKSpriteNode?
    var originalColor = SKColor(named: "notPressed")!
    var originalColorStroke = SKColor.clear
    var highlightColor: SKColor?
    var optionsOriginal: String?
    var optionsPressed: String?
    var highlightStroke: SKColor?
    
    func setText(text: String){
        if textNode.parent == nil{
            addChild(textNode)
            textNode.fontName = "Helvetica"
            textNode.fontColor = UIColor.black
            textNode.fontSize = 15
            textNode.verticalAlignmentMode = .center
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
        }
        textNode.text = text
    }
    
    func setImage(imageNamed: String, scale: CGFloat){
        if let icon = self.icon {
            icon.removeFromParent()
        }
        let icon = SKSpriteNode(imageNamed: imageNamed)
        icon.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
        icon.setScale(scale)
        addChild(icon)
        self.icon = icon
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let action = SKAction.scale(by: 0.9, duration: 0.1)
        //run(action)
        if let optionsPressed = self.optionsPressed{
            setImage(imageNamed: optionsPressed, scale: 0.07)
        }
        if let highlightColor = highlightColor {
            originalColor = fillColor
            fillColor = highlightColor
            
        }
        if let highlightStroke = highlightStroke{
            originalColorStroke = strokeColor
            strokeColor = highlightStroke
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let action = SKAction.scale(by: 1.0/0.9, duration: 0.1)
        //run(action)
        if let _ = optionsPressed, let optionsOriginal = optionsOriginal {
            setImage(imageNamed: optionsOriginal, scale: 0.07)
        }
        if let _ = highlightColor {
            fillColor = originalColor
        }
        if let _ = highlightStroke{
            strokeColor = originalColorStroke
        }
        if let touch = touches.first, let parent = parent{
            if frame.contains(touch.location(in: parent)){
                if let delegate = delegate{
                    delegate.onTap(sender: self)
                }
            }
        }
    }
}
