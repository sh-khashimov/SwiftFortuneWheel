//
//  LinePreferences.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/17/20.
//

import Foundation
import UIKit

/// Line Preferences
public struct LinePreferences {

    /// Stroke width
    public var height: CGFloat = 1

    /// Stroke color type
    public var colorType: SwiftFortuneWheelConfiguration.ColorType

    /// Vertical offset in slice from the center
    public var verticalOffset: CGFloat

    /// Initiates a line preferences
    /// - Parameters:
    ///   - height: Line height, default value is `1`
    ///   - colorType: Line color type
    ///   - verticalOffset: Line vertical offset, default value is `0`
    public init(colorType: SwiftFortuneWheelConfiguration.ColorType,
                height: CGFloat = 1,
                verticalOffset: CGFloat = 0) {
        self.height = height
        self.colorType = colorType
        self.verticalOffset = verticalOffset
    }
}
