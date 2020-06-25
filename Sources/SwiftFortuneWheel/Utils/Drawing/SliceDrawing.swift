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
                self.drawCurved(text: text, in: context, preferences: preferences, rotation: rotation, index: index, topOffset: topOffset)
            } else {
                self.drawHorizontal(text: text, in: context, preferences: preferences, rotation: rotation, index: index, topOffset: topOffset)
            }
        case .vertical:
            // Not finished yet
//            self.drawVertical(text: text, in: context, preferences: preferences, rotation: rotation, index: index, topOffset: topOffset)
            self.drawHorizontal(text: text, in: context, preferences: preferences, rotation: rotation, index: index, topOffset: topOffset)
        }
        return preferences.preferedFontSize + preferences.verticalOffset
    }

    /// Draws curved text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    private func drawCurved(text: String, in context:CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) {

        var textColor: UIColor = .black

        switch preferences.textColorType {
        case .evenOddColors(let evenColor, let oddColor):
            textColor = index % 2 == 0 ? evenColor : oddColor
        case .customPatternColors(let colors, let defaultColor):
            textColor = colors?[index, default: defaultColor] ?? defaultColor
        }

        let bottomYPosition = -(radius - preferences.verticalOffset - topOffset - preferences.preferedFontSize)
        let width = self.width(forYPosition: bottomYPosition)
        let textRect = CGRect(x: 0, y: 0, width: width, height: preferences.preferedFontSize)
        let yPosition = -(radius - preferences.verticalOffset - topOffset - topMargin) + textRect.height / 2

        context.saveGState()

        let angleRotation = -(rotation + contextPositionCorrectionOffsetDegree) * CGFloat.pi/180

        self.centreArcPerpendicular(text: text, context: context, radius: -yPosition, angle: angleRotation, colour: textColor, font: preferences.font, clockwise: preferences.flipUpsideDown, preferedSize: textRect.size)

        context.restoreGState()

    }

    /// Draws text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    private func drawHorizontal(text: String, in context:CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) {

        var textColor: UIColor = .black

        switch preferences.textColorType {
        case .evenOddColors(let evenColor, let oddColor):
            textColor = index % 2 == 0 ? evenColor : oddColor
        case .customPatternColors(let colors, let defaultColor):
            textColor = colors?[index, default: defaultColor] ?? defaultColor
        }

        let textFontAttributes: [NSAttributedString.Key:Any] = {
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            let deafultAttributes:[NSAttributedString.Key: Any] =
                [.font: preferences.font,
                 .foregroundColor: textColor,
                 .paragraphStyle: textStyle ]
            return deafultAttributes
        }()

        let bottomYPosition = -(radius - preferences.verticalOffset - topOffset - preferences.preferedFontSize)
        let width = self.width(forYPosition: bottomYPosition)
        let textRect = CGRect(x: 0, y: 0, width: width, height: preferences.preferedFontSize)
        let yPosition = -(radius - preferences.verticalOffset - topOffset - topMargin)

        context.saveGState()
        context.rotate(by: rotation * CGFloat.pi/180)

        if preferences.flipUpsideDown {
            context.rotate(by: flipRotation)
        }

        text.draw(in: CGRect(x: -(textRect.width / 2) - preferences.horizontalOffset, y: yPosition, width: textRect.width, height: textRect.height), withAttributes: textFontAttributes)

        context.restoreGState()

    }

    /// Draws text
    /// - Parameters:
    ///   - text: text
    ///   - context: context where to draw
    ///   - preferences: text preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    private func drawVertical(text: String, in context: CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) {

        var textColor: UIColor = .black

        switch preferences.textColorType {
        case .evenOddColors(let evenColor, let oddColor):
            textColor = index % 2 == 0 ? evenColor : oddColor
        case .customPatternColors(let colors, let defaultColor):
            textColor = colors?[index, default: defaultColor] ?? defaultColor
        }

        let textFontAttributes: [NSAttributedString.Key:Any] = {
            let textStyle = NSMutableParagraphStyle()
            textStyle.alignment = .center
            let deafultAttributes:[NSAttributedString.Key: Any] =
                [.font: preferences.font,
                 .foregroundColor: textColor,
                 .paragraphStyle: textStyle ]
            return deafultAttributes
        }()

        let textWidth: CGFloat = text.width(by: preferences.font)

        let maxAvailableBottomRadiusOffsetCircularSegmentHeight = self.leftMargin + self.rightMargin + preferences.preferedFontSize
        let bottomRadiusOffset = max(self.bottomMargin, radius(circularSegmentHeight: maxAvailableBottomRadiusOffsetCircularSegmentHeight, from: sliceDegree))

        let availableHeightInSlice: CGFloat = radius - preferences.verticalOffset - topOffset - bottomRadiusOffset
        let textRectWidth = min(textWidth, availableHeightInSlice)
        let croppedText = text.crop(by: textRectWidth, font: preferences.font)

//        let bottomYPosition = -(radius - preferences.verticalOffset - topOffset - preferences.preferedFontSize)
        let textRect = CGRect(x: 0, y: 0, width: textRectWidth, height: preferences.preferedFontSize)
        let yPosition = -(radius - preferences.verticalOffset - topOffset - topMargin)
        let xPos = -(textRect.width / 2) - preferences.horizontalOffset

        context.saveGState()
        context.rotate(by: rotation * CGFloat.pi/180)
        context.translateBy(x: xPos + textRect.height / 2, y: yPosition + textRect.width / 2)
        context.rotate(by: 90 * CGFloat.pi/180)


//        context.rotate(by: 90 * CGFloat.pi/180)

        if preferences.flipUpsideDown {
            context.rotate(by: flipRotation)
        }

//        croppedText.draw(in: CGRect(x: 0, y: 0, width: textRect.width, height: textRect.height), withAttributes: textFontAttributes)
//        croppedText.draw(in: CGRect(x: -(textRect.width / 2) - preferences.horizontalOffset - rotationOffset / 2, y: yPosition - rotationOffset / 2 , width: textRect.width, height: textRect.height), withAttributes: textFontAttributes)
//        context.addRect(textRect)
//        UIColor.red.setStroke()
//        context.drawPath(using: .fillStroke)
        croppedText.draw(in: CGRect(x: -textRect.width / 2, y: -textRect.height / 2, width: textRect.width, height: textRect.height), withAttributes: textFontAttributes)

        context.restoreGState()

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

        context.saveGState()
        context.rotate(by: (rotation - contextPositionCorrectionOffsetDegree) * CGFloat.pi/180)

        var strokeColor = UIColor.clear

        switch preferences.colorType {
        case .evenOddColors(let evenColor, let oddColor):
            strokeColor = index % 2 == 0 ? evenColor : oddColor
        case .customPatternColors(let colors, let defaultColor):
            strokeColor = colors?[index, default: defaultColor] ?? defaultColor
        }

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
