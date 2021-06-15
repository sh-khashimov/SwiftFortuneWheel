//
//  SFGradientColor.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 15/06/21.
//  Copyright © 2021 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Gradient Color
public struct SFGradientColor {
    
    /// Color Space
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    /// Colors
    public var colors: [SFWColor]
    
    /// Color Locations
    public var colorLocations: [CGFloat]
    
    /// Gradient Type
    public var type: GradientType
    
    /// Gradient Direction (ignores when GradientType == .radial)
    public var direction: Direction
    
    /// Initializes Gradient Color
    /// - Parameters:
    ///   - colors: Colors
    ///   - colorLocations: Color Locations
    ///   - type: Gradient Type
    ///   - direction: Gradient Direction (ignores when GradientType == .radial), default value `.vertical`
    public init(colors: [SFWColor], colorLocations: [CGFloat], type: GradientType, direction: Direction = .vertical) {
        self.colors = colors
        self.colorLocations = colorLocations
        self.type = type
        self.direction = direction
    }
}


extension SFGradientColor {
    /// Gradient Type
    public enum GradientType {
        case linear
        case radial
    }
}


extension SFGradientColor {
    /// Gradient Direction
    public enum Direction {
        case vertical
        case horizontal
    }
}


extension SFGradientColor {
    /// Gradient
    public var gradient: CGGradient? {
        let gradient = CGGradient(
            colorsSpace: colorSpace,
            colors: colors.map({ $0.cgColor }) as CFArray,
            locations: colorLocations
        )
        return gradient
    }
}
