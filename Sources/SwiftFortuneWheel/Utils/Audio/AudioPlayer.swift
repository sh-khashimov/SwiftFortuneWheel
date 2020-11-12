//
//  AudioPlayer.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 10/20/20.

import Foundation
import AVFoundation

/// Audio player that plays sound
class AudioPlayer {
    /// A class that plays buffers or segments of audio files
    let node = AVAudioPlayerNode()
    /// Audio player state
    var state: State = State.idle()
    
    /// Plays `AVAudioFile` for sound identifier
    /// - Parameters:
    ///   - file: Audio file that will be played
    ///   - identifier: Sound identifier which is will start to play
    func play(_ file: AVAudioFile, identifier: SoundIdentifier) {
        if #available(iOS 11.0, iOSApplicationExtension 11.0, OSX 10.13, OSXApplicationExtension 10.13, tvOS 11.0, tvOSApplicationExtension 11.0, *) {
            node.scheduleFile(file, at: nil, completionCallbackType: .dataPlayedBack) {
                [weak self] callbackType in
                self?.didCompletePlayback(for: identifier)
            }
        } else {
            // Fallback on earlier versions
            node.scheduleFile(file, at: nil) { [weak self] in
                self?.didCompletePlayback(for: identifier)
            }
        }
        state = State(sound: identifier, status: .playing)
        node.play()
    }
    
    /// Called when Audio player completed playback
    /// - Parameter sound: Sound identifier which is completed
    func didCompletePlayback(for sound: SoundIdentifier) {
        state = State.idle()
    }
}

extension AudioPlayer {
    /// Audio player's status type
    enum Status {
        case idle
        case playing
        case looping
    }
}

extension AudioPlayer {
    /// Audio player's state type
    struct State {
        /// An audio player sound identifier used to play sound by identifier
        let sound: SoundIdentifier?
        /// Audio player's  current status
        let status: Status
        
        /// Puts the audio player on idle status
        /// - Returns: self
        static func idle() -> State {
            return State(sound: nil, status: .idle)
        }
    }
}
