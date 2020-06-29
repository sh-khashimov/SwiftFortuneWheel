//
//  Drawing.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation
import UIKit
import CoreGraphics

/// Slice drawing protocol
protocol SliceDrawing: WheelMathCalculating, SliceCalculating, CurveTextDrawing {}

extension SliceDrawing {

    /// Circular segment height
    var circularSegmentHeight: CGFloat {
        self.circularSegmentHeight(from: sliceDegree)
    }

    /// Content left margin
    var leftMargin: CGFloat {
        self.preferences?.contentMargins.left ?? 0
    }

    /// Content right margin
    var rightMargin: CGFloat {
        self.preferences?.contentMargins.right ?? 0
    }

    /// Content top margin
    var topMargin: CGFloat {
        self.preferences?.contentMargins.top ?? 0
    }

    /// Content bottom margin
    var bottomMargin: CGFloat {
        self.preferences?.contentMargins.top ?? 0
    }


    /// Context position correction offset degree
    var contextPositionCorrectionOffsetDegree: CGFloat {
        return -90
    }

    /// Width for Y postion
    /// - Parameter yPosition: Y position
    /// - Returns: new width
    func width(forYPosition yPosition: CGFloat) -> CGFloat {
        let width = circularSegmentHeight(radius: -yPosition, from: sliceDegree) - leftMargin - rightMargin
        return width
    }

    /// Available text rectangles for the specified position
    /// - Parameters:
    ///   - yPosition: Y Position
    ///   - preferences: Text preferences
    ///   - topOffset: Top offset
    /// - Returns: Available text rectangles
    func availableTextRect(yPosition: CGFloat, preferences: TextPreferences, topOffset: CGFloat) -> [CGRect] {

        /// Max. available height from Y position
        let maxHeight = radius - abs(yPosition) - bottomMargin

        /// Max. available lines for String
        let maxLines = preferences.numberOfLines == 0 ? Int((maxHeight / preferences.font.pointSize).rounded(.towardZero)) : preferences.numberOfLines

        /// Text rectangles
        var textRects: [CGRect] = []

        /// Creates rectangle for each line
        for line in 1...maxLines {
            /// Height offset
            let heightOffset = preferences.font.pointSize * CGFloat(line)
            /// Spacing
            let spacing = line == 1 ? 0 : preferences.spacing * CGFloat(line)
            /// Y position of the rectangle bottoms
            let bottomYPosition = -(radius - preferences.verticalOffset - topOffset - heightOffset - spacing)
            /// Width
            let width = self.width(forYPosition: bottomYPosition)
            /// Text rectangle
            let textRect = CGRect(x: 0, y: 0, width: width, height: preferences.font.pointSize)
            textRects.append(textRect)
        }
        return textRects
    }
}

extension SliceDrawing {

    /// Draw slice with content
    /// - Parameters:
    ///   - index: index
    ///   - context: context where to draw
    ///   - slice: slice content object
    ///   - rotation: rotation degree
    ///   - start: start degree
    ///   - end: end degree
    func drawSlice(withIndex index:Int, in context:CGContext, forSlice slice: Slice, rotation:CGFloat, start: CGFloat, end: CGFloat) {

        //// Context setup
        context.saveGState()
        // Coordinate now start from center
        context.translateBy(x: rotationOffset, y: rotationOffset)

        // Draws slice path and background
        self.drawPath(in: context, backgroundColor: slice.backgroundColor, start: start, and: end, rotation: rotation, index: index)

        var topOffset: CGFloat = 0

        // Draws slice content
        slice.contents.enumerated().forEach { (contentIndex, element) in
            switch element {
            case .text(let text, let preferences):
                topOffset += prepareDraw(text: text, in: context, preferences: preferences, rotation: rotation, index: index, topOffset: topOffset)
            case .image(let name, let preferenes):
                self.drawImage(in: context, imageName: name, preferences: preferenes, rotation: rotation, index: index, topOffset: topOffset)
                topOffset += preferenes.preferredSize.height + preferenes.verticalOffset
            case .line(let preferenes):
                self.drawLine(in: context, preferences: preferenes, start: start, and: end, rotation: rotation, index: index, topOffset: topOffset)
                topOffset += preferenes.height
            }
        }

        context.restoreGState()
    }

    /// Draws slice path and background
    /// - Parameters:
    ///   - context: context where to draw
    ///   - start: start degree
    ///   - end: end degree
    ///   - rotation: rotation degree
    ///   - index: index
    private func drawPath(in context: CGContext, backgroundColor: UIColor?, start: CGFloat, and end: CGFloat, rotation:CGFloat, index: Int) {

        context.saveGState()
        context.rotate(by: (rotation + contextPositionCorrectionOffsetDegree) * CGFloat.pi/180)

        var pathBackgroundColor = backgroundColor

        if pathBackgroundColor == nil {
            switch preferences?.slicePreferences.backgroundColorType {
            case .some(.evenOddColors(let evenColor, let oddColor)):
                pathBackgroundColor = index % 2 == 0 ? evenColor : oddColor
            case .customPatternColors(let colors, let defaultColor):
                pathBackgroundColor = colors?[index, default: defaultColor] ?? defaultColor
            case .none:
                break
            }
        }

        let strokeColor = preferences?.slicePreferences.strokeColor
        let strokeWidth = preferences?.slicePreferences.strokeWidth

        let path = UIBezierPath()
        let center = CGPoint(x: 0, y: 0)
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: torad(start), endAngle: torad(end), clockwise: true)
        pathBackgroundColor?.setFill()
        path.fill()
        strokeColor?.setStroke()
        path.lineWidth = strokeWidth ?? 0
        path.stroke()
        context.restoreGState()
    }

    /// Draws image
    /// - Parameters:
    ///   - context: context where to draw
    ///   - imageName: image  name from assets catalog
    ///   - preferences: image preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    private func drawImage(in context: CGContext, imageName: String, preferences: ImagePreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) {
        guard var image = UIImage(named: imageName, in: nil, compatibleWith: nil) else { return }

        if let tintColor = preferences.tintColor {
            if #available(iOS 13.0, *) {
                image = image.withTintColor(tintColor, renderingMode: .alwaysTemplate)
            } else {
                // Fallback on earlier versions
                image = image.withColor(tintColor)
            }
        }

        context.saveGState()
        context.rotate(by: rotation * CGFloat.pi/180)

        let aspectRatioRect = preferences.preferredSize.aspectFit(sizeImage: image.size)
        let yPositionWithoutOffset = radius - preferences.verticalOffset - topOffset
        let yPosition = yPositionWithoutOffset + (aspectRatioRect.size.height / 2)

        let rectangle = CGRect(x: -(aspectRatioRect.size.width / 2), y: -yPosition, width: aspectRatioRect.size.width, height: aspectRatioRect.size.height)

        if let backgroundColor = preferences.backgroundColor {
            backgroundColor.setFill()
            context.fill(rectangle)
        }

        image.draw(in: rectangle, blendMode: .normal, alpha: 1)

        if preferences.flipUpsideDown {
            context.rotate(by: flipRotation)
        }
        context.restoreGState()
    }

    /// Prepare to draw text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    /// - Returns: height of the drawn text
    func prepareDraw(text: String, in context: CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) -> CGFloat {
        switch preferences.orientation {
        case .horizontal:
            if preferences.isCurved {
                return self.drawCurved(text: text, in: context, preferences: preferences, rotation: rotation, index: index, topOffset: topOffset)
            } else {
                return self.drawHorizontal(text: text, in: context, preferences: preferences, rotation: rotation, index: index, topOffset: topOffset)
            }
        case .vertical:
            return self.drawVertical(text: text, in: context, preferences: preferences, rotation: rotation, index: index, topOffset: topOffset)
        }
    }

    /// Draws curved text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    /// - Returns: Height of the drawn text
    private func drawCurved(text: String, in context:CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) -> CGFloat {

        let textColor = preferences.color(for: index)

        /// Y start position
        let yPosition = -(radius - preferences.verticalOffset - topOffset - topMargin) + preferences.font.pointSize / 2

        /// Text rectangles for multiline text
        let textRects = availableTextRect(yPosition: yPosition, preferences: preferences, topOffset: topOffset)

        /// String with multiline
        let multilineString = text.split(font: preferences.font, lineWidths: textRects.map({ $0.width }), lineBreak: preferences.lineBreakMode)


        /// Height for al text lines
        let height = preferences.font.pointSize * CGFloat(multilineString.count) + preferences.spacing * max(0, CGFloat(multilineString.count - 1))

        for index in 0..<multilineString.count {

            /// The string that will be drawn
            let string = multilineString[index]
            /// Space between lines
            let spacing = index == 0 ? 0 : preferences.spacing * CGFloat(index)

            /// Current text rectangle
            let textRect = textRects[index]

            /// Y position of the current line
            let yPos = yPosition + textRect.height * CGFloat(index) + spacing
            context.saveGState()

            let angleRotation = -(rotation + contextPositionCorrectionOffsetDegree) * CGFloat.pi/180

            self.centreArcPerpendicular(text: string, context: context, radius: -yPos, angle: angleRotation, colour: textColor, font: preferences.font, clockwise: preferences.flipUpsideDown, preferedSize: textRect.size)

            context.restoreGState()
        }

        return height + preferences.verticalOffset

    }

    /// Draws text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    /// - Returns: Height of the drawn text
    private func drawHorizontal(text: String, in context:CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) -> CGFloat {

        /// Text attributes
        let textFontAttributes = preferences.textAttributes(for: index)

        /// Y start position
        let yPosition = -(radius - preferences.verticalOffset - topOffset - topMargin)

        /// Text rectangles for multiline text
        var textRects = availableTextRect(yPosition: yPosition, preferences: preferences, topOffset: topOffset)

        /// If text not flipped, reverse text rectangle to start crop from the bottom
        if !preferences.flipUpsideDown {
            textRects.reverse()
        }

        /// String with multiline
        var multilineString = text.split(font: preferences.font, lineWidths: textRects.map({ $0.width }), lineBreak: preferences.lineBreakMode)

        /// Height for al textl lines
        let height = preferences.font.pointSize * CGFloat(multilineString.count) + preferences.spacing * max(0, CGFloat(multilineString.count - 1))

        /// If text not flipped, reverse text and text rectangle
        if !preferences.flipUpsideDown {
            multilineString.reverse()
            textRects.reverse()
        }

        /// Start draw each string line
        for index in 0..<multilineString.count {

            /// The string that will be drawn
            let string = multilineString[index]
            /// Space between lines
            let spacing = index == 0 ? 0 : preferences.spacing * CGFloat(index)

            /// Current text rectangle
            let textRect = textRects[index]
            /// X position of the current line
            let xPos = -(textRect.width / 2) - preferences.horizontalOffset
            /// Y position of the current line
            let yPos = yPosition + textRect.height * CGFloat(index) + spacing

            context.saveGState()
            context.rotate(by: rotation * CGFloat.pi/180)

            context.translateBy(x: xPos, y: yPos)

            if !preferences.flipUpsideDown {
                context.rotate(by: flipRotation)
                context.translateBy(x: -textRect.width, y: -textRect.height)
            }

            string.draw(in: CGRect(x: 0, y: 0, width: textRect.width, height: CGFloat.infinity), withAttributes: textFontAttributes)

            context.restoreGState()
        }

        return height + preferences.verticalOffset

    }

    /// Draws text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    /// - Returns: Height of the drawn text
    private func drawVertical(text: String, in context: CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) -> CGFloat {

        /// Text attributes
        let textAttributes = preferences.textAttributes(for: index)

        /// Available words
        let wordsCount = text.split(separator: " ".first!).count

        /// Maximum available width in slice
        let maxWidth = circularSegmentHeight(radius: radius - preferences.verticalOffset - topOffset, from: sliceDegree)

        /// Maximum available lines in slice
        let maxLinesInSlice = (maxWidth / (preferences.font.pointSize + preferences.spacing)).rounded(.down)

        /// Available text rectangles
        var availableTextRects: [CGRect] = []

        /// Counts max available vertical lines and create for each line a max text rectangle
        for line in 1...Int(maxLinesInSlice - 1) {
            /// Spacing between lines
            let spacing = line > 1 ? preferences.spacing : 0

            /// Height of text rectangle
            let _height = preferences.font.pointSize * CGFloat(line) + preferences.spacing * (CGFloat(line) - 1)
            /// Maximum circular segment height (chord) for current line (rectangle)
            let _maxCircularSegmentHeight = self.leftMargin + self.rightMargin + _height
            /// Bottom radius offset
            let _bottomRadiusOffset = max(self.bottomMargin, radius(circularSegmentHeight: _maxCircularSegmentHeight, from: sliceDegree))
            /// Available width in slice
            let _availableWidthInSlice = radius - preferences.verticalOffset - topOffset - _bottomRadiusOffset
            /// Current line space
            let _currentLineSpace = (_availableWidthInSlice * _height)

            /// Height of the next text rectangle
            let _nextHeight = preferences.font.pointSize * CGFloat(line + 1) + preferences.spacing * (CGFloat(line))
            /// Maximum circular segment height (chord) for current line (rectangle)
            let _nextMaxCircularSegmentHeight = self.leftMargin + self.rightMargin + _nextHeight + spacing
            /// Bottom radius offset for next line
            let _nextBottomRadiusOffset = max(self.bottomMargin, radius(circularSegmentHeight: _nextMaxCircularSegmentHeight, from: sliceDegree))
            /// Available width in slice for next line
            let _nextAvailableWidthInSlice = radius - preferences.verticalOffset - topOffset - _nextBottomRadiusOffset
            /// Next line space
            let _nextLineSpace = (_nextAvailableWidthInSlice * _nextHeight)

            availableTextRects.append(CGRect(x: 0, y: 0, width: _availableWidthInSlice, height: _height))

            if _currentLineSpace > _nextLineSpace {
                break
            }
        }

        /// String with multiline
        var multilineString: [String] = []

        /// Text rectangles for multiline text
        var textRects: [CGRect] = []

        /// creates text rectangles from available max text rectangle
        for index in 0..<availableTextRects.count {
            textRects = []
            multilineString = []

            /// Text rectangle
            let textRect = availableTextRects[index]
            /// Current line
            let line = index + 1

            /// split the availableTextRect to the text rectangles
            textRects = Array(repeating: CGRect(x: 0, y: 0, width: textRect.width, height: preferences.font.pointSize), count: line)
            multilineString = text.split(font: preferences.font, lineWidths: textRects.map({ $0.width }), lineBreak: preferences.lineBreakMode)

            /// Word count for text in the current line
            let _wordCount = max(multilineString.joined().split(separator: " ".first!).count, line)

            if wordsCount == _wordCount {
                break
            }
        }


        /// Line count
        let lineCount = multilineString.count

        /// Spacing between lines
        let spacing = lineCount > 1 ? preferences.spacing : 0

        /// Context widths
        let contextWidth = preferences.font.pointSize * CGFloat(lineCount) + spacing * max(0, (CGFloat(lineCount) - 1))

        /// Context height
        let contextHeight = textRects.first?.width ?? 0

        /// Y start position
        let yPosition = -(radius - preferences.verticalOffset - topOffset - topMargin)

        /// If text not flipped, reverse text
        if !preferences.flipUpsideDown {
            multilineString.reverse()
        }

        /// Start draw each string line
        for index in 0..<multilineString.count {

            /// The string that will be drawn
            let string = multilineString[index]
            /// Space between lines
            let spacing = index == 0 ? 0 : preferences.spacing * CGFloat(index)

            /// Current text rectangle
            let textRect = textRects[index]
            /// X position of the current line
            let xPos = textRect.height * CGFloat(index + 1) + spacing - contextWidth / 2

            context.saveGState()
            context.rotate(by: rotation * CGFloat.pi/180)

            context.translateBy(x: xPos, y: yPosition)
            context.rotate(by: 90 * CGFloat.pi/180)

            if preferences.flipUpsideDown {
                context.rotate(by: flipRotation)
                context.translateBy(x: -textRect.width, y: -textRect.height)
            }

            //         For Debugging purposes
//            context.addRect(textRect)
//            UIColor.red.setStroke()
//            context.drawPath(using: .fillStroke)

            string.draw(in: CGRect(x: 0, y: 0, width: textRect.width, height: CGFloat.infinity), withAttributes: textAttributes)

            context.restoreGState()
        }

        return contextHeight + preferences.verticalOffset

    }
}

extension SliceDrawing {
    /// Draws rectangle
    /// - Parameters:
    ///   - context: context where to draw
    ///   - rotation: rotation degree
    func drawRectangle(in context: CGContext, rotation: CGFloat) {
        context.saveGState()
        context.rotate(by: rotation * CGFloat.pi/180)

        let rectangleHeight: CGFloat = 20
        let rectangle = CGRect(x: 0 - (rectangleHeight / 2), y: (-radius / 2) - (rectangleHeight / 2), width: rectangleHeight, height: rectangleHeight)
        context.addRect(rectangle)
        context.drawPath(using: .fillStroke)

        context.restoreGState()
    }

    /// Draws curved line
    /// - Parameters:
    ///   - context: context where to draw
    ///   - preferences: Line preferences
    ///   - start: start degree
    ///   - end: end degree
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    func drawLine(in context: CGContext, preferences: LinePreferences, start: CGFloat, and end: CGFloat, rotation: CGFloat, index: Int, topOffset: CGFloat) {

        let strokeColor = preferences.strokeColor(for: index)

        context.saveGState()
        context.rotate(by: (rotation - contextPositionCorrectionOffsetDegree) * CGFloat.pi/180)

        let strokeWidth = preferences.height

        let yPosition = radius - preferences.verticalOffset - topOffset

        let path = UIBezierPath()
        let center = CGPoint(x: 0, y: 0)
//        path.move(to: center)
        path.addArc(withCenter: center, radius: -yPosition, startAngle: torad(start), endAngle: torad(end), clockwise: true)
        UIColor.clear.setFill()
        path.fill()
        strokeColor.setStroke()
        path.lineWidth = strokeWidth
        path.stroke()
        context.restoreGState()
    }

    /// Draws anchor image
    /// - Parameters:
    ///   - context: context where to draw
    ///   - imageAnchor: anchor image
    ///   - rotation: rotation degree
    ///   - index: index
    func drawAnchorImage(in context: CGContext, imageAnchor: SwiftFortuneWheelConfiguration.AnchorImage, isCentered: Bool, rotation: CGFloat, index: Int) {

        //// Context setup
        context.saveGState()
        // Coordinate now start from center
        context.translateBy(x: rotationOffset, y: rotationOffset)

        guard var image = UIImage(named: imageAnchor.imageName, in: nil, compatibleWith: nil) else { return }

        if let tintColor = imageAnchor.tintColor {
            if #available(iOS 13.0, *) {
                image = image.withTintColor(tintColor, renderingMode: .alwaysTemplate)
            } else {
                // Fallback on earlier versions
                image = image.withColor(tintColor)
            }
        }

        let centeredOffset: CGFloat = isCentered ? sliceDegree / 2 : 0
        let contextPositionCorrectionOffsetDegree: CGFloat = -sliceDegree / 2 + imageAnchor.rotationDegreeOffset + centeredOffset

        context.saveGState()
        context.rotate(by: (rotation + contextPositionCorrectionOffsetDegree) * CGFloat.pi/180)

        let yPosition: CGFloat = radius - imageAnchor.verticalOffset
        let xPosition: CGFloat = imageAnchor.size.width / 2

        let rectangle = CGRect(x: -xPosition, y: -yPosition, width: imageAnchor.size.width, height: imageAnchor.size.height)

        image.draw(in: rectangle, blendMode: .normal, alpha: 1)

        context.restoreGState()
        context.restoreGState()
    }
}
