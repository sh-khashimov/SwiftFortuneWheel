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
        self.drawPath(in: context, start: start, and: end, rotation: rotation, index: index)

        var topOffset: CGFloat = 0

        // Draws slice content
        slice.contents.enumerated().forEach { (contentIndex, element) in
            switch element {
            case .text(let text, let preferenes):
                if preferenes.isCurved {
                    self.drawCurved(text: text, in: context, preferences: preferenes, rotation: rotation, index: index, topOffset: topOffset)
                } else {
                    self.draw(text: text, in: context, preferences: preferenes, rotation: rotation, index: index, topOffset: topOffset)
                }
                topOffset += preferenes.preferedFontSize + preferenes.verticalOffset
            case .image(let name, let preferenes):
                self.drawImage(in: context, imageName: name, preferences: preferenes, rotation: rotation, index: index, topOffset: topOffset)
                topOffset += preferenes.preferredSize.height + preferenes.verticalOffset
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
    private func drawPath(in context: CGContext, start: CGFloat, and end: CGFloat, rotation:CGFloat, index: Int) {

        let contextPositionCorrectionOffsetDegree: CGFloat = -90

        context.saveGState()
        context.rotate(by: (rotation + contextPositionCorrectionOffsetDegree) * CGFloat.pi/180)

        var backgroundColor: UIColor = .clear

        switch preferences?.slicePreferences.backgroundColorType {
        case .some(.evenOddColors(let evenColor, let oddColor)):
            backgroundColor = index % 2 == 0 ? evenColor : oddColor
        case .customPatternColors(let colors, let defaultColor):
            backgroundColor = colors?[index, default: defaultColor] ?? defaultColor
        case .none:
            break
        }

        let strokeColor = preferences?.slicePreferences.strokeColor
        let strokeWidth = preferences?.slicePreferences.strokeWidth

        let path = UIBezierPath()
        let center = CGPoint(x: 0, y: 0)
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: torad(start), endAngle: torad(end), clockwise: true)
        backgroundColor.setFill()
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

        let contextPositionCorrectionOffsetDegree: CGFloat = -90

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
    private func draw(text: String, in context:CGContext, preferences: TextPreferences, rotation: CGFloat, index: Int, topOffset: CGFloat) {

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

        text.draw(in: CGRect(x: -(textRect.width / 2) - preferences.horizontalOffset, y: yPosition, width: textRect.width, height: textRect.height), withAttributes: textFontAttributes)

        if preferences.flipUpsideDown {
            context.rotate(by: flipRotation)
        }

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

    /// Draws anchor image
    /// - Parameters:
    ///   - context: context where to draw
    ///   - imageAnchor: anchor image
    ///   - rotation: rotation degree
    ///   - index: index
    func drawAnchorImage(in context: CGContext, imageAnchor: SwiftFortuneWheelConfiguration.AnchorImage, rotation: CGFloat, index: Int) {

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

        let contextPositionCorrectionOffsetDegree: CGFloat = -sliceDegree / 2 + imageAnchor.rotationDegreeOffset

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
