//
//  SwiftFortuneWheelConfiguration.swift
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

/// Configuration, contains preferences to configure a fortune wheel
public struct SFWConfiguration {
    
    /// Spin button preferences
    public var spinButtonPreferences: SpinButtonPreferences?
    
    /// Pin (arrow) view preferences
    public var pinPreferences: PinImageViewPreferences?
    
    /// Wheel preferences
    public var wheelPreferences: WheelPreferences
    
    #if os(macOS)
    /// Used to expand the clipping area
    public var alignmentRectInsets: NSEdgeInsets?
    #endif
    
    /// Initiates a configuration
    /// - Parameters:
    ///   - wheelPreferences: Wheel preferences
    ///   - pinPreferences: Pin (arrow) view preferences, `optional`
    ///   - spinButtonPreferences: Spin button preferences, `optional`
    public init(wheelPreferences: WheelPreferences,
                pinPreferences: PinImageViewPreferences? = nil,
                spinButtonPreferences: SpinButtonPreferences? = nil) {
        self.wheelPreferences = wheelPreferences
        self.pinPreferences = pinPreferences
        self.spinButtonPreferences = spinButtonPreferences
    }
}

public extension SFWConfiguration {
    /// Wheel preferences
    struct WheelPreferences {
        
        /// Circle preferences
        public var circlePreferences: CirclePreferences
        
        /// Slice preferences
        public var slicePreferences: SlicePreferences
        
        /// Start position, should be equal to FortuneWheelConfiguration.pinPreferences.position
        public var startPosition: Position
        
        /// Layer insets, used to center the drawing such that offseted graphics(e.g Shadows, Outer Glows) are not clipped.
        /// Can be increased to any size if needed. Default value is `UIEdgeInsets(top: -50, left: -50, bottom: -50, right: -50)`
        public var layerInsets: SFWEdgeInsets = SFWEdgeInsets(top: -50, left: -50, bottom: -50, right: -50)
        
        /// Margins for content inside a slide
        public var contentMargins: Margins = Margins()
        
        /// Image anchor for each slice, located at the wheel's border, `optional`
        public var imageAnchor: AnchorImage? = nil
        
        /// Image anchor for each slice, located at the center of wheel's border, `optional`
        public var centerImageAnchor: AnchorImage? = nil
        
        var layerInsetsWithCircleWidth: SFWEdgeInsets {
            let circleWidth = self.circlePreferences.strokeWidth
            return SFWEdgeInsets(top: layerInsets.top - circleWidth,
                                left: layerInsets.left - circleWidth,
                                bottom: layerInsets.bottom - circleWidth,
                                right: layerInsets.right - circleWidth)
        }
        
        /// Initiates a wheel preferences
        /// - Parameters:
        ///   - circlePreferences: Circle preferences
        ///   - slicePreferences: Slice preferences
        ///   - startPosition: Start position, should be equal to FortuneWheelConfiguration.pinPreferences.position
        public init(circlePreferences: CirclePreferences,
                    slicePreferences: SlicePreferences,
                    startPosition: Position) {
            self.circlePreferences = circlePreferences
            self.slicePreferences = slicePreferences
            self.startPosition = startPosition
        }
    }
}

public extension SFWConfiguration {
    /// Circle preferences
    struct CirclePreferences {
        
        /// Stroke width
        public var strokeWidth: CGFloat = 1
        
        /// Stroke color
        public var strokeColor: SFWColor = .black
        
        /// Initiates a circle preferences
        /// - Parameters:
        ///   - strokeWidth: Stroke width, default value is `1`
        ///   - strokeColor: Stroke color, default value is `.black`
        public init(strokeWidth: CGFloat = 1,
                    strokeColor: SFWColor = .black) {
            self.strokeWidth = strokeWidth
            self.strokeColor = strokeColor
        }
    }
}

public extension SFWConfiguration {
    /// Slice preferences
    struct SlicePreferences {
        
        /// Background color type
        public var backgroundColorType: ColorType
        
        /// Stroke width
        public var strokeWidth: CGFloat
        
        /// Stroke color
        public var strokeColor: SFWColor
        
        /// Background image content mode
        public var backgroundImageContentMode: ContentMode = .scaleAspectFill
        
        /// Initiates a slice preferences
        /// - Parameters:
        ///   - backgroundColorType: Background color type
        ///   - strokeWidth: Stroke width, default value is `1`
        ///   - strokeColor: Stroke color, default value is `.black`
        public init(backgroundColorType: ColorType,
                    strokeWidth: CGFloat = 1,
                    strokeColor: SFWColor = .black) {
            self.backgroundColorType = backgroundColorType
            self.strokeWidth = strokeWidth
            self.strokeColor = strokeColor
        }
    }
}

public extension SFWConfiguration {
    /// Spin button preferences
    struct SpinButtonPreferences {
        
        /// Size
        public var size: CGSize
        
        /// Corner radius, default value is `0`
        public var cornerRadius: CGFloat = 0
        
        /// Corner width, default value is `0`
        public var cornerWidth: CGFloat = 0
        
        /// Corner color, default  value is `.clear`
        public var cornerColor: SFWColor = .clear
        
        /// Horizontal offset
        public var horizontalOffset: CGFloat
        
        /// Vertical offset
        public var verticalOffset: CGFloat
        
        /// Background color, default value is `.clear`
        public var backgroundColor: SFWColor = .clear
        
        /// Text Color, default value is `.black`
        public var textColor: SFWColor = .black
        
        /// Disabled text color, default value is `.black`
        public var disabledTextColor: SFWColor = .black
        
        /// Font, default value is `.systemFont(ofSize: 16, weight: .semibold)`
        public var font: SFWFont = .systemFont(ofSize: 16, weight: .semibold)
        
        /// Initiates a spin button preferences
        /// - Parameters:
        ///   - size: Size
        ///   - horizontalOffset: Horizontal offset, default value is `0`
        ///   - verticalOffset: Vertical offset, default value is `0`
        public init(size: CGSize,
                    horizontalOffset: CGFloat = 0,
                    verticalOffset: CGFloat = 0) {
            self.size = size
            self.horizontalOffset = horizontalOffset
            self.verticalOffset = verticalOffset
        }
        
        /// Creates text attributes, relative to slice index position
        /// - Parameter index: Slice index
        /// - Returns: Text attributes
        var textAttributes: [NSAttributedString.Key:Any] {
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            textStyle.lineBreakMode = .byWordWrapping
            let deafultAttributes:[NSAttributedString.Key: Any] =
                [.font: self.font,
                 .foregroundColor: textColor,
                 .paragraphStyle: textStyle ]
            return deafultAttributes
        }
    }
}


public extension SFWConfiguration {
    /// Pin image view preferences
    struct PinImageViewPreferences {
        
        /// Size
        public var size: CGSize
        
        /// Position
        public var position: Position
        
        /// Horizontal offset
        public var horizontalOffset: CGFloat
        
        /// Vertical offset
        public var verticalOffset: CGFloat
        
        /// Background color, default value is `.clear`
        public var backgroundColor: SFWColor = .clear
        
        /// Tint color, `optional`
        public var tintColor: SFWColor? = nil
        
        /// Initiates a pin image view preferences
        /// - Parameters:
        ///   - size: Size
        ///   - position: Position
        ///   - horizontalOffset: Horizontal offset, default value is `0`
        ///   - verticalOffset: Vertical offset, default value is `0`
        public init(size: CGSize,
                    position: Position,
                    horizontalOffset: CGFloat = 0,
                    verticalOffset: CGFloat = 0) {
            self.size = size
            self.position = position
            self.horizontalOffset = horizontalOffset
            self.verticalOffset = verticalOffset
        }
    }
}

public extension SFWConfiguration {
    /// Position, pin or start position
    enum Position {
        case top
        case bottom
        case left
        case right
        
        /// Start position angle offset in degree.
        /// Used for wheel
        var startAngleOffset: CGFloat {
            switch self {
            case .top:
                return 0
            case .right:
                return 90
            case .bottom:
                return 180
            case .left:
                return 270
            }
        }
    }
}

public extension SFWConfiguration {
    /// Margins
    struct Margins {
        
        /// Left margin
        var left: CGFloat
        
        /// Right margin
        var right: CGFloat
        
        /// Top margin
        var top: CGFloat
        
        /// Bottom margin
        var bottom: CGFloat
        
        /// Initiates a margins with default values:
        /// top = 3;
        /// left = 2;
        /// right = 2;
        /// bottom = 3
        public init() {
            self.top = 3
            self.left = 2
            self.right = 2
            self.bottom = 3
        }
        
        /// Initiates a margins
        /// - Parameters:
        ///   - top: Top margin
        ///   - left: Left margin
        ///   - right: Right margin
        ///   - bottom: Bottom margin, default value is `0`
        public init(top: CGFloat, left: CGFloat, right: CGFloat, bottom: CGFloat = 0) {
            self.top = top
            self.left = left
            self.right = right
            self.bottom = bottom
        }
    }
}

public extension SFWConfiguration {
    /// Color type, used to color the item with the particularized pattern.
    /// `evenOddColors` -  decorates with a two-color pattern, for odd or even item in the list.
    /// `customPatternColors` - decorates with specified color for each item on the list.
    enum ColorType {
        case evenOddColors(evenColor: SFWColor, oddColor: SFWColor)
        case customPatternColors(colors: [SFWColor]?, defaultColor: SFWColor)
    }
}

public extension SFWConfiguration {
    /// Anchor image used  to add images around the wheel for each slice
    struct AnchorImage {
        
        /// Size, required
        public var size: CGSize
        
        /// Image name from assets catalog
        public var imageName: String
        
        /// Rotation degree offset, default value is `0`
        public var rotationDegreeOffset: CGFloat = 0
        
        /// Vertical offset
        public var verticalOffset: CGFloat
        
        /// Tint color, `optional`
        public var tintColor: SFWColor? = nil
        
        /// Initiates a anchor image object
        /// - Parameters:
        ///   - imageName: Image name from assets catalog
        ///   - size: Size, required
        ///   - verticalOffset: Vertical offset, default value is `0`
        public init(imageName: String,
                    size: CGSize,
                    verticalOffset: CGFloat = 0) {
            self.imageName = imageName
            self.size = size
            self.verticalOffset = verticalOffset
        }
    }
}


public extension SFWConfiguration {
    /// Content can be drawn by specified mode
    enum ContentMode {
        case scaleAspectFill
        case bottom
    }
}
