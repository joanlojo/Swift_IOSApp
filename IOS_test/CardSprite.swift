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
