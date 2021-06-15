//
//  Slice.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
// 
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Slice object that will be drawn as a custom content
public struct Slice {
    /// Contents in vertical align order
    public var contents: [ContentType]
    
    /// Background color, `optional`
    public var backgroundColor: SFWColor?
    
    /// Background image, `optional`
    public var backgroundImage: SFWImage?
    
    /// Background gradient color, `optional`
    public var gradientColor: SFGradientColor?
    
    /// Initiates a slice object
    /// - Parameter contents: Contents in vertical align order
    /// - Parameter backgroundColor: Background color, `optional`
    /// - Parameter gradientColor: Background gradient color,, `optional`
    /// - Parameter backgroundImage: Background image, `optional`
    public init(contents: [ContentType],
                backgroundColor: SFWColor? = nil,
                gradientColor: SFGradientColor? = nil,
                backgroundImage: SFWImage? = nil) {
        self.contents = contents
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.gradientColor = gradientColor
    }
}

extension Slice {
    /// Slice content type, currently image or text
    public enum ContentType {
        case assetImage(name: String, preferences: ImagePreferences)
        case image(image: SFWImage, preferences: ImagePreferences)
        case text(text: String, preferences: TextPreferences)
        case line(preferences: LinePreferences)
    }
}
