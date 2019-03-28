//
//  CardSprite.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 21/03/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit

class CardSprite: SKSpriteNode {
    var textureFront: SKTexture
    var textureBack: SKTexture
    
    init(size: CGSize, textureFront: SKTexture, textureBack: SKTexture){
        self.textureFront = textureFront
        self.textureBack = textureBack
        super.init(texture: nil, color: .white, size: size)
        self.texture = textureBack
    }
    
    func showCard(){
        //addChild(self)  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
