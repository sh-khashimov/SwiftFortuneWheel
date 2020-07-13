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

    /// Horizontal offset in slice from the center
    public var horizontalOffset: CGFloat

    /// Vertical offset in slice from the center
    public var verticalOffset: CGFloat

    /// Flip the text upside down
    public var flipUpsideDown: Bool

    /// Text font
    public var font: UIFont

    /// Text color type
    public var textColorType: SFWConfiguration.ColorType
    
    /// Is text curved or not, works only with orientation equal to horizontal
    public var isCurved: Bool

    /// Text orientation
    public var orientation: Orientation

    /// The technique to use for wrapping and truncating the label’s text
    public var lineBreakMode: LineBreakMode

    /// The maximum number of lines to use for rendering text.
    public var numberOfLines: Int

    /// Spacing between lines
    public var spacing: CGFloat

    /// The technique to use for aligning the text.
    public var alignment: NSTextAlignment

    /// Initiates a text preferences
    /// - Parameters:
    ///   - textColorType: Text color type
    ///   - font: Font
    ///   - preferedFontSize: Prefered font size, requared to calculate a size
    ///   - verticalOffset: Vertical offset in slice from the center, default value is `0`
    ///   - horizontalOffset: Horizontal offset in slice from the center, default value is `0`
    ///   - orientation: Text orientation, default value is `.horizontal`
    ///   - alignment: The technique to use for aligning the text, default value is `.left`
    ///   - lineBreakMode: The technique to use for wrapping and truncating the label’s text, default value is `.clip`
    ///   - numberOfLines: The maximum number of lines to use for rendering text., default valie is `1`
    ///   - spacing: Spacing between lines, default value is `3`
    ///   - flipUpsideDown: Flip the text upside down, default value is `false`
    ///   - isCurved: Is text curved or not, works only with orientation equal to horizontal, default value is `true`
    public init(textColorType: SFWConfiguration.ColorType,
                font: UIFont,
                verticalOffset: CGFloat = 0,
                horizontalOffset: CGFloat = 0,
                orientation: Orientation = .horizontal,
                lineBreak: LineBreakMode = .clip,
                alignment: NSTextAlignment = .center,
                lines: Int = 1,
                spacing: CGFloat = 3,
                flipUpsideDown: Bool = true,
                isCurved: Bool = true) {
        self.textColorType = textColorType
        self.horizontalOffset = horizontalOffset
        self.verticalOffset = verticalOffset
        self.flipUpsideDown = flipUpsideDown
        self.font = font
        self.isCurved = isCurved
        self.orientation = orientation
        self.lineBreakMode = lineBreak
        self.numberOfLines = lines
        self.spacing = spacing
        self.alignment = alignment
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

        /// NSLineBreakMode
        var systemLineBreakMode: NSLineBreakMode {
            switch self {
            case .clip:
                return .byClipping
            case .truncateTail:
                return .byTruncatingTail
            case .wordWrap:
                return .byWordWrapping
            }
        }
    }
}

extension TextPreferences {

    /// Creates a color for text, relative to slice index position
    /// - Parameter index: Slice index
    /// - Returns: Color
    func color(for index: Int) -> UIColor {
        var color: UIColor = .clear

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
