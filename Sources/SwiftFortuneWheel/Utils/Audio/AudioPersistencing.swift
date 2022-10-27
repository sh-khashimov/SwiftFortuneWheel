//
//  AudioPersistencing.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 27/10/22.
//  Copyright © 2022 SwiftFortuneWheel. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioPersistencing {
    func enableHandleInterruption()
}

extension AudioPersistencing {
#if canImport(AVAudioSession)
    func enableHandleInterruption() {
        NotificationCenter.default.addObserver(self,
                           selector: #selector(handleInterruption),
                           name: AVAudioSession.interruptionNotification,
                           object: AVAudioSession.sharedInstance())
    }
    
    /// Stops audio when interrupted
    @objc func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
               let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
               let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                   return
           }
        
        isAudioInterrupted = type == .began
        
        if isAudioInterrupted {
            node.stop()
        }
    }
#else
    func enableHandleInterruption() {
        //do nothing
    }
#endif
}
