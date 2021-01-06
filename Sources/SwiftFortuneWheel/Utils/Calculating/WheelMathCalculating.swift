//
//  WheelMathCalculating.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Wheel other math calculation protocol
protocol WheelMathCalculating: class {
    
    /// Wheel frame
    var frame: CGRect { get set }
    
    /// Wheel main frame
    var mainFrame: CGRect! { get set }
    
    /// Wheel preferences
    var preferences: SFWConfiguration.WheelPreferences? { get set }
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
    
    /// Circular segment height for degree
    /// - Parameter degree: degree
    /// - Returns: height
    func circularSegmentHeight(from degree: CGFloat) -> CGFloat {
        return .circularSegmentHeight(radius: radius, from: degree)
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
