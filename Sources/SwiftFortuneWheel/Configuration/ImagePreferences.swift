//
//  ImagePreferences.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
// 
//

import Foundation
import UIKit

/// Image preferences
public struct ImagePreferences {

    /// Prefered image size, required
    public var preferredSize: CGSize

    /// Horizontal offset in slice from the center
    public var horizontalOffset: CGFloat

    /// Vertical offset in slice from the center
    public var verticalOffset: CGFloat

    /// Flip the text upside down
    public var flipUpsideDown: Bool

    /// Background color
    public var backgroundColor: UIColor?

    /// Tint color
    public var tintColor: UIColor?

    /// Initiates a image preferences
    /// - Parameters:
    ///   - preferredSize: Prefered image size, required
    ///   - verticalOffset: Vertical offset in slice from the center
    ///   - horizontalOffset: Horizontal offset in slice from the center, default value is `0`
    ///   - flipUpsideDown: Flip the text upside down, default value is `false`
    ///   - tintColor: Tint color, `optional`
    ///   - backgroundColor: Background color, `optional`
    public init(preferredSize: CGSize,
                verticalOffset: CGFloat,
                horizontalOffset: CGFloat = 0,
                flipUpsideDown: Bool = false,
                tintColor: UIColor? = nil,
                backgroundColor: UIColor? = nil) {
        self.preferredSize = preferredSize
        self.horizontalOffset = horizontalOffset
        self.verticalOffset = verticalOffset
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.flipUpsideDown = flipUpsideDown
    }
}
