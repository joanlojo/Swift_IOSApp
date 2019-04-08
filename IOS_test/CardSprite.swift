//
//  CardSprite.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 21/03/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit

protocol CardSpriteDelegate: class {
    func onTap(sender: CardSprite)
}

class CardSprite: SKSpriteNode {
    
    weak var delegate: CardSpriteDelegate?
    
    var card: Card?
    var textureFront: SKTexture
    var textureBack: SKTexture
    
    init(size: CGSize, textureFront: SKTexture, textureBack: SKTexture){
        self.textureFront = textureFront
        self.textureBack = textureBack
        super.init(texture: nil, color: .white, size: size)
        self.texture = textureBack
        self.isUserInteractionEnabled = true
    }
    
    func showCard(){
        //addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    func changeTexture(texture: SKTexture) {
        
        let toZeroScaleAction = SKAction.scaleX(to: 0, duration: 0.1)
        let toOriginalScaleAction = SKAction.scaleX(to: 10, duration: 0.1)
        
        let sequence = SKAction.sequence([
            toZeroScaleAction,
            SKAction.setTexture(texture),
            toOriginalScaleAction
            ])
        self.run(sequence)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let parent = parent{
            if frame.contains(touch.location(in: parent)){
                if let delegate = delegate{
                    delegate.onTap(sender: self)
                }
            }
        }
    }
}
