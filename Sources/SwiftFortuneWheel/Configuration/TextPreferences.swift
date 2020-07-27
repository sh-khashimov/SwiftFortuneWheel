//
//  TextPreferences.swift
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

/// Text preferemces
public struct TextPreferences {
    
    /// Text font
    public var font: SFWFont
    
    /// Text color type
    public var textColorType: SFWConfiguration.ColorType
    
    /// Horizontal offset in slice from the center, default value is `0`
    public var horizontalOffset: CGFloat = 0
    
    /// Vertical offset in slice from the center
    public var verticalOffset: CGFloat
    
    /// Flip the text upside down, default value is `true`
    public var flipUpsideDown: Bool = true
    
    /// Is text curved or not, works only with orientation equal to horizontal, default value is `true`
    public var isCurved: Bool = true
    
    /// Text orientation, default value is `.horizontal`
    public var orientation: Orientation = .horizontal
    
    /// The technique to use for wrapping and truncating the label’s text, default value is `.clip`
    public var lineBreakMode: LineBreakMode = .clip
    
    /// The maximum number of lines to use for rendering text., default valie is `1`
    public var numberOfLines: Int = 1
    
    /// Spacing between lines, default value is `3`
    public var spacing: CGFloat = 3
    
    /// The technique to use for aligning the text, default value is `.left`
    public var alignment: NSTextAlignment = .center
    
    /// Maximum width that will be available for text
    public var maxWidth: CGFloat = .greatestFiniteMagnitude
    
    /// Initiates a text preferences
    /// - Parameters:
    ///   - textColorType: Text color type
    ///   - font: Font
    ///   - verticalOffset: Vertical offset in slice from the center, default value is `0`
    public init(textColorType: SFWConfiguration.ColorType,
                font: SFWFont,
                verticalOffset: CGFloat = 0) {
        self.textColorType = textColorType
        self.font = font
        self.verticalOffset = verticalOffset
    }
}

public extension TextPreferences {
    /// Text orientation, horizontal or vertical
    enum Orientation {
        case horizontal
        case vertical
    }
}

public extension TextPreferences {
    /// The technique to use for wrapping and truncating the label’s text
    enum LineBreakMode {
        case clip
        case truncateTail
        case wordWrap
        case characterWrap
        
        /// NSLineBreakMode
        var systemLineBreakMode: NSLineBreakMode {
            switch self {
            case .clip:
                return .byClipping
            case .truncateTail:
                return .byTruncatingTail
            case .wordWrap:
                return .byWordWrapping
            case .characterWrap:
                return  .byCharWrapping
            }
        }
    }
}

extension TextPreferences {
    
    /// Creates a color for text, relative to slice index position
    /// - Parameter index: Slice index
    /// - Returns: Color
    func color(for index: Int) -> SFWColor {
        var color: SFWColor = .clear
        
        switch self.textColorType {
        case .evenOddColors(let evenColor, let oddColor):
            color = index % 2 == 0 ? evenColor : oddColor
        case .customPatternColors(let colors, let defaultColor):
            color = colors?[index, default: defaultColor] ?? defaultColor
        }
        return color
    }
    
    /// Creates text attributes, relative to slice index position
    /// - Parameter index: Slice index
    /// - Returns: Text attributes
    func textAttributes(for index: Int) -> [NSAttributedString.Key:Any] {
        let textColor = self.color(for: index)
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = alignment
        textStyle.lineBreakMode = lineBreakMode.systemLineBreakMode
        textStyle.lineSpacing = spacing
        let deafultAttributes:[NSAttributedString.Key: Any] =
            [.font: self.font,
             .foregroundColor: textColor,
             .paragraphStyle: textStyle ]
        return deafultAttributes
    }
}
