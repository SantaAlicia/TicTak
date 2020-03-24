//
//  GameEffectsViewController.swift
//  TicTak
//
//  Created by liudmila vladimirova on 22/03/2020.
//  Copyright © 2020 SantaAlicia. All rights reserved.
//

import UIKit
import AVFoundation

class GameEffectsViewController: NSObject {

    var audioPlayer: AVAudioPlayer?
    static let shared = GameEffectsViewController()
}

extension GameEffectsViewController {
    
    func prepareToPlay() {
        guard let url = Bundle.main.url(forResource: "sound1", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let audioPlayer = audioPlayer else { return }
            //audioPlayer.numberOfLoops = -1
            audioPlayer.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSound() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.play()
    }
    
    func stopSound() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }

}
