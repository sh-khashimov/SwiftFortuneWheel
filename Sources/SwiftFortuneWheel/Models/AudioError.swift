//
//  AudioError.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 10/20/20.

import Foundation

/// Audio related error
enum AudioError: Error {
    case resourceNotFound(name: String)
    case invalidSoundIdentifier(name: String)
    case audioLoadingFailure
}


extension AudioError: CustomStringConvertible {
    /// Error's description
    var description: String {
        switch self {
        case .resourceNotFound(let name):
            return "Resource not found '\(name)'"
        case .invalidSoundIdentifier(let name):
            return "Invalid identifier. No sound loaded named '\(name)'"
        case .audioLoadingFailure:
            return "Could not load audio data"
        }
    }
}
