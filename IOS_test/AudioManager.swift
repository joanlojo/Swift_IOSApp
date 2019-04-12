//
//  AudioController.swift
//  IOS_test
//
//  Created by Marc Segarra on 11/04/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import Foundation
import AVFoundation

class AudioController {
    var soundPressed: Bool = false

    let player = AVPlayer(url: Bundle.main.url(forResource: "mainTheme.mp3", withExtension: nil)!)
    
    private static let sharedAudioController = AudioController()
    
    static var shared: AudioController{
        return sharedAudioController
    }
    
    init() {
        
    }
    
    func play(){
        player.play()
    }
    
    func pause(){
        player.pause()
    }
    
    func stop(){
        player.pause()
        player.seek(to: CMTime.zero)
    }
    
    func on(){
        player.volume = 1.0
    }
    
    func off(){
        player.volume = 0.0
    }
    
}
