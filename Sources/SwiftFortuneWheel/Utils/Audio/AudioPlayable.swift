//
//  AudioPlayable.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 11/2/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

/// The protocol used to play audio files
protocol AudioPlayable {
    /// Audio Player Manager
    var audioPlayerManager: AudioPlayerManager { get }
    /// The sound that used to play when edge anchor collide
    var edgeCollisionSound: AudioFile? { get set }
    /// The sound that used to play when center anchor collide
    var centerCollisionSound: AudioFile? { get set }
}

extension AudioPlayable {
    
    /// Prepares sound for audio file
    /// - Parameter audioFile: Audio file
    func prepareSoundFor(audioFile: AudioFile?) {
        guard let audioFile = audioFile else { return }
        audioPlayerManager.load(audioFile: audioFile)
    }
    
    /// Plays sound for audio file
    /// - Parameter audioFile: Audio file
    func playSound(audioFile: AudioFile) {
        guard let identifier = audioFile.identifier else { return }
        audioPlayerManager.play(identifier, allowOverlap: true)
    }
    
    /// Plays sound if needed for collision type
    /// - Parameter type: Collision type
    func playSoundIfNeeded(type: CollisionType) {
        let audioFile: AudioFile?
        switch type {
        case .edge:
            audioFile = edgeCollisionSound
        case .center:
            audioFile = centerCollisionSound
        }
        guard let _audioFile = audioFile else { return }
        playSound(audioFile: _audioFile)
    }
}
