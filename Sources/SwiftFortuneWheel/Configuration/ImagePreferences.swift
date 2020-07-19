//
//  ImagePreferences.swift
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

/// Image preferences
public struct ImagePreferences {
    
    /// Prefered image size, required
    public var preferredSize: CGSize
    
    /// Horizontal offset in slice from the center, default value is `0`
    public var horizontalOffset: CGFloat = 0
    
    /// Vertical offset in slice from the center
    public var verticalOffset: CGFloat
    
    /// Flip the text upside down, default value is `false`
    public var flipUpsideDown: Bool = false
    
    /// Background color, `optional`
    public var backgroundColor: SFWColor? = nil
    
    /// Tint color, `optional`
    public var tintColor: SFWColor? = nil
    
    /// Initiates a image preferences
    /// - Parameters:
    ///   - preferredSize: Prefered image size, required
    ///   - verticalOffset: Vertical offset in slice from the center, default value is `0`
    public init(preferredSize: CGSize,
                verticalOffset: CGFloat = 0) {
        self.preferredSize = preferredSize
        self.verticalOffset = verticalOffset
    }
}
