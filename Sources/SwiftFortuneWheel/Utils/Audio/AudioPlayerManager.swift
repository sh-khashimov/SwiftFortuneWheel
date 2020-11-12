//
//  AudioPlayerManager.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 10/20/20.
//
//  Copyright (C) Matthew Reagan 2018
// https://github.com/matthewreagan/Starling

import Foundation
import AVFoundation

/// Typealias used for identifying specific sound effects
public typealias SoundIdentifier = String

/// Audio Player Manager, used to control the sound playing process
class AudioPlayerManager {
    
    /// Defines the number of players which Starling instantiates
    /// during initialization. If more concurrent sounds than this
    /// are requested at any point, Starling will allocate additional
    /// players as needed, up to `maximumTotalPlayers`.
    private static let defaultStartingPlayerCount = 30
    
    /// Defines the total number of concurrent sounds which Starling
    /// will allow to be played at the same time. If (N) sounds are
    /// already playing and another play() request is made, it will
    /// be ignored (not queued).
    private static let maximumTotalPlayers = 500
    
    private var players = SynchronizedArray<AudioPlayer>()
    private var files = SynchronizedDictionary<String, AVAudioFile>()
    private let engine = AVAudioEngine()
    
    /// Initializes the Audio Playe Manager
    public init() {
        assert(AudioPlayerManager.defaultStartingPlayerCount <= AudioPlayerManager.maximumTotalPlayers, "Invalid starting and max audio player counts.")
        assert(AudioPlayerManager.defaultStartingPlayerCount > 0, "Starting audio player count must be > 0.")

        for _ in 0..<AudioPlayerManager.defaultStartingPlayerCount {
            players.append(createNewPlayerAttachedToEngine())
        }
        
        do {
            try engine.start()
        } catch {
            handleNonFatalError(error)
        }
    }
    
    // MARK: - Loading Sounds
    
    /// Loads sound with Audio file
    /// - Parameter audioFile: Audio file
    func load(audioFile: AudioFile) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let blockSelf = self else { return }
            guard let url = audioFile.url, let identifier = audioFile.identifier else {
                blockSelf.handleNonFatalError(AudioError.resourceNotFound(name: "\(audioFile.filename ?? "").\(audioFile.extensionName ?? "")"))
                return
            }
            blockSelf.load(sound: url, for: identifier)
        }
    }
    
    /// Loads sound with URL for sound' identifier
    /// - Parameters:
    ///   - url: File's URL
    ///   - identifier: Sound's identifier
    func load(sound url: URL, for identifier: SoundIdentifier) {
        if let file = try? AVAudioFile(forReading: url) {
            didFinishLoadingAudioFile(file, identifier: identifier)
        } else {
            handleNonFatalError(AudioError.audioLoadingFailure)
        }
    }
    
    // MARK: - Playback
    
    /// Plays sound with an identifier
    /// - Parameters:
    ///   - sound: Sound's identifier
    ///   - allowOverlap: Allow overlap sound each other
    func play(_ sound: SoundIdentifier, allowOverlap: Bool = true) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.performSoundPlayback(sound, allowOverlap: allowOverlap)
        }
    }
    
    // MARK: - Internal Functions
    
    private func performSoundPlayback(_ sound: SoundIdentifier, allowOverlap: Bool) {
        // Note: self is used as the lock pointer here to avoid
        // the possibility of locking on _swiftEmptyDictionaryStorage
        let file = files[sound]
        
        guard let audio = file else {
            handleNonFatalError(AudioError.invalidSoundIdentifier(name: sound))
            return
        }
        
        func performPlaybackOnFirstAvailablePlayer() {
            guard let player = firstAvailablePlayer() else { return }
            
            player.play(audio, identifier: sound)
        }
        
        if allowOverlap {
           performPlaybackOnFirstAvailablePlayer()
        } else {
            if !soundIsCurrentlyPlaying(sound) {
                performPlaybackOnFirstAvailablePlayer()
            }
        }
    }
    
    private func soundIsCurrentlyPlaying(_ sound: SoundIdentifier) -> Bool {
        // TODO: This O(n) loop could be eliminated by simply keeping a playback tally
        for player in players.synchronizedArray {
            let state = player.state
            if state.status != .idle && state.sound == sound {
                return true
            }
        }
        return false
    }
    
    private func firstAvailablePlayer() -> AudioPlayer? {
        let player: AudioPlayer? = {
            // TODO: A better solution would be to actively manage a pool of available player references
            // For almost every general use case of this library, however, this performance penalty is trivial
            let player = players.synchronizedArray.first(where: { $0.state.status == .idle })
            if player == nil && players.count < AudioPlayerManager.maximumTotalPlayers {
                let newPlayer = createNewPlayerAttachedToEngine()
                players.append(newPlayer)
                return newPlayer
            }
            return player
        }()
        
        return player
    }
    
    private func createNewPlayerAttachedToEngine() -> AudioPlayer {
        let player = AudioPlayer()
        engine.attach(player.node)
        engine.connect(player.node, to: engine.mainMixerNode, format: nil)
        return player
    }
    
    private func didFinishLoadingAudioFile(_ file: AVAudioFile, identifier: SoundIdentifier) {
        // Note: self is used as the lock pointer here to avoid
        // the possibility of locking on _swiftEmptyDictionaryStorage
        files[identifier] = file
    }
    
    private func handleNonFatalError(_ error: Error) {
        print("*** Starling error: \(error)")
    }
}
