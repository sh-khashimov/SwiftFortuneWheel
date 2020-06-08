//
//  WheelMathCalculating.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation
import UIKit

/// Wheel other math calculation protocol
protocol WheelMathCalculating: class {

    /// Wheel frame
    var frame: CGRect { get set }

    /// Wheel main frame
    var mainFrame: CGRect! { get set }

    /// Wheel preferences
    var preferences: SwiftFortuneWheelConfiguration.WheelPreferences? { get set }
}

extension WheelMathCalculating {

    /// Radius
    var radius:CGFloat {
        return mainFrame.height / 2.0
    }

    /// Rotation offset
    var rotationOffset:CGFloat {
        return (mainFrame.width) / 2 + abs(preferences?.layerInsets.top ?? 0)
    }

    /// Flip rotation
    var flipRotation: CGFloat {
        return CGFloat.pi
    }

    /// to rad.
    /// - Parameter f: degree
    /// - Returns: postion
    func torad(_ f: CGFloat) -> CGFloat {
        return f * .pi / 180.0
    }

    /// Circular segment height for degree
    /// - Parameter degree: degree
    /// - Returns: height
    func circularSegmentHeight(from degree: CGFloat) -> CGFloat {
        return circularSegmentHeight(radius: radius, from: degree)
    }

    /// Circular segment height for radius and degree
    /// - Parameters:
    ///   - radius: degree
    ///   - degree: radius
    /// - Returns: height
    func circularSegmentHeight(radius: CGFloat, from degree: CGFloat) -> CGFloat {
        return 2 * radius * sin(degree / 2.0 * CGFloat.pi / 180)
    }

    /// Updates frame sizes
    func updateSizes(updateFrame: Bool = true) {
        if let layerInsets = preferences?.layerInsets {
            self.mainFrame = CGRect(origin: CGPoint(x: abs(layerInsets.left), y: abs(layerInsets.top)), size: frame.size)
            if updateFrame {
                self.frame = frame.inset(by: layerInsets)
            }
        } else {
            self.mainFrame = self.frame
        }
    }
}
