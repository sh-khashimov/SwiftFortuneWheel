//
//  TextPreferences.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
// 
//

import Foundation
import UIKit

/// Text preferemces
public struct TextPreferences {

    /// Horizontal offset in slice from the center
    public var horizontalOffset: CGFloat

    /// Vertical offset in slice from the center
    public var verticalOffset: CGFloat

    /// Flip the text upside down
    public var flipUpsideDown: Bool

    /// Text font
    public var font: UIFont

    /// Prefered font size, requared to calculate a size
    public var preferedFontSize: CGFloat

    /// Text color type
    public var textColorType: SwiftFortuneWheelConfiguration.ColorType
    
    /// Is text curved or not, works only with orientation equal to horizontal
    public var isCurved: Bool

    /// Text orientation
    public var orientation: Orientation

    /// Initiates a text preferences
    /// - Parameters:
    ///   - textColorType: Text color type
    ///   - font: Font
    ///   - preferedFontSize: Prefered font size, requared to calculate a size
    ///   - verticalOffset: Vertical offset in slice from the center, default value is `0`
    ///   - horizontalOffset: Horizontal offset in slice from the center, default value is `0`
    ///   - flipUpsideDown: Flip the text upside down, default value is `false`
    ///   - isCurved: Is text curved or not, works only with orientation equal to horizontal, default value is `true`
    public init(textColorType: SwiftFortuneWheelConfiguration.ColorType,
                font: UIFont,
                preferedFontSize: CGFloat,
                verticalOffset: CGFloat = 0,
                horizontalOffset: CGFloat = 0,
                orientation: Orientation = .horizontal,
                flipUpsideDown: Bool = true,
                isCurved: Bool = true) {
        self.textColorType = textColorType
        self.horizontalOffset = horizontalOffset
        self.verticalOffset = verticalOffset
        self.flipUpsideDown = flipUpsideDown
        self.font = font
        self.preferedFontSize = preferedFontSize
        self.isCurved = isCurved
        self.orientation = orientation
    }
}

public extension TextPreferences {
    /// Text orientation, horizontal or vertical
    enum Orientation {
        case horizontal
        case vertical
    }
}
