//
//  GameEffectsViewController.swift
//  Tic-Tac-Toe
//
//  Created by liudmila vladimirova on 22/03/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit
import AVFoundation

class GameSoundEffectController: NSObject {

    var audioPlayer: AVAudioPlayer?
    var audioPlayerOneStep: AVAudioPlayer?
    var audioPlayerOneStep2: AVAudioPlayer?
    let audioSession : AVAudioSession = AVAudioSession.sharedInstance()
    static let shared = GameSoundEffectController()
}

extension GameSoundEffectController {
    
    func prepareToPlaySound() {
        guard let url = Bundle.main.url(forResource: "soundGameOver", withExtension: "mp3") else { return }
        guard let url_oneStep = Bundle.main.url(forResource: "soundChock", withExtension: "mp3") else { return }

        do {
            try audioSession.setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayer?.delegate = self
            
            audioPlayerOneStep = try AVAudioPlayer(contentsOf: url_oneStep, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayerOneStep?.delegate = self
            
            audioPlayerOneStep2 = try AVAudioPlayer(contentsOf: url_oneStep, fileTypeHint: AVFileType.mp3.rawValue)
            audioPlayerOneStep2?.delegate = self

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
    
    func playGameSoundOverWithDelay() {
        let delayInSeconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            guard let self = self else { return }
            self.playSoundGameOver()
       }
    }
    
    func playSoundOneStep() {
        guard let audioPlayerOneStep = audioPlayerOneStep else { return }
        audioPlayerOneStep.play()
    }
    
    func playSoundOneStep2() {
        guard let audioPlayerOneStep2 = audioPlayerOneStep2 else { return }
        audioPlayerOneStep2.play()
       }
    
    func playSoundOneStepTwice(needTwice:Bool) {
        playSoundOneStep()
        if (!needTwice) { return }
        let delayInSeconds = 0.7
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            guard let self = self else { return }
            self.playSoundOneStep2()
        }
    }
}

extension  GameSoundEffectController : AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        //
    }
}
