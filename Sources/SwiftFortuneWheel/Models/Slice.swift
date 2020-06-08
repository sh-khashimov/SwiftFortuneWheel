//
//  Slice.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
// 
//

import Foundation

/// Slice object that will be drawn as a custom content
public struct Slice {
    /// Contents in vertical align order
    var contents: [ContentType]

    /// Initiates a slice object
    /// - Parameter contents: Contents in vertical align order
    public init(contents: [ContentType]) {
        self.contents = contents
    }
}

extension Slice {
    /// Slice content type, currently image or text
    public enum ContentType {
        case image(name: String, preferenes: ImagePreferences)
        case text(text: String, preferenes: TextPreferences)
    }
}
