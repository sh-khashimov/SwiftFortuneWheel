//
//  Slice.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
// 
//

import Foundation
import UIKit

/// Slice object that will be drawn as a custom content
public struct Slice {
    /// Contents in vertical align order
    public var contents: [ContentType]

    /// Background color, `optional`
    public var backgroundColor: UIColor?

    /// Initiates a slice object
    /// - Parameter contents: Contents in vertical align order
    /// - Parameter backgroundColor: Background color, `optional`
    public init(contents: [ContentType],
                backgroundColor: UIColor? = nil) {
        self.contents = contents
        self.backgroundColor = backgroundColor
    }
}

extension Slice {
    /// Slice content type, currently image or text
    public enum ContentType {
        case assetImage(name: String, preferences: ImagePreferences)
        case image(image: UIImage, preferences: ImagePreferences)
        case text(text: String, preferences: TextPreferences)
        case line(preferences: LinePreferences)
    }
}
