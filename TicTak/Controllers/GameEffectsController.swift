//
//  GameEffectsViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 22/03/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit
import AVFoundation

class GameEffectsController: NSObject {

    var audioPlayer: AVAudioPlayer?
    var audioPlayerOneStep: AVAudioPlayer?
    let audioSession : AVAudioSession = AVAudioSession.sharedInstance()
    static let shared = GameEffectsController()
}

extension GameEffectsController {
    
    func prepareToPlaySound() {
        guard let url = Bundle.main.url(forResource: "soundGameOver", withExtension: "mp3") else { return }
        guard let url_oneStep = Bundle.main.url(forResource: "soundChock", withExtension: "mp3") else { return }

        do {
            try audioSession.setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer?.delegate = self
            audioPlayerOneStep = try AVAudioPlayer(contentsOf: url_oneStep, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayerOneStep?.delegate = self

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let audioPlayer = audioPlayer else { return }
            //audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
            guard let audioPlayerOneStep = audioPlayerOneStep else { return }
            audioPlayerOneStep.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSoundGameOver() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.play()
    }
    
//    func stopSoundGameOver() {
//        guard let audioPlayer = audioPlayer else { return }
//        audioPlayer.stop()
//    }
    
    func playSoundOneStep() {
        guard let audioPlayerOneStep = audioPlayerOneStep else { return }
        audioPlayerOneStep.play()
    }
    
//    func stopSoundOneStep() {
//        guard let audioPlayerOneStep = audioPlayerOneStep else { return }
//        audioPlayerOneStep.stop()
//    }
}

extension  GameEffectsController : AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        //
    }
}
