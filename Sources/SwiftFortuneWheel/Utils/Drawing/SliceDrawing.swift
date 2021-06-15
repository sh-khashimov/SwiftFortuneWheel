//
//  Drawing.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation
import CoreGraphics

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Slice drawing protocol
protocol SliceDrawing: WheelMathCalculating, SliceCalculating, TextDrawing, ImageDrawing, ShapeDrawing {}

extension SliceDrawing {
    
    /// Circular segment height
    var circularSegmentHeight: CGFloat {
        self.circularSegmentHeight(from: sliceDegree)
    }
    
    /// Content margins
    var margins: SFWConfiguration.Margins {
        var margins = self.preferences?.contentMargins ?? SFWConfiguration.Margins()
        margins.top = margins.top + (self.preferences?.circlePreferences.strokeWidth ?? 0) / 2
        margins.left = margins.left + (self.preferences?.circlePreferences.strokeWidth ?? 0)
        margins.right = margins.right + (self.preferences?.circlePreferences.strokeWidth ?? 0)
        margins.bottom = margins.bottom + (self.preferences?.circlePreferences.strokeWidth ?? 0) / 2
        return margins
    }
    
    
    /// Context position correction offset degree
    var contextPositionCorrectionOffsetDegree: CGFloat {
        return -90
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
        
        //         Draws slice path and background
        self.drawPath(in: context,
                      backgroundColor: slice.backgroundColor,
                      backgroundGradientColor: slice.gradientColor,
                      backgroundImage: slice.backgroundImage,
                      start: start,
                      and: end,
                      rotation: rotation,
                      index: index)
        
        var topOffset: CGFloat = 0
        
        // Draws slice content
        slice.contents.enumerated().forEach { (contentIndex, element) in
            switch element {
            case .text(let text, let preferences):
                topOffset += prepareDraw(text: text,
                                         in: context,
                                         preferences: preferences,
                                         rotation: rotation,
                                         index: index,
                                         topOffset: topOffset)
            case .assetImage(let imageName, let preferences):
                guard imageName != "", let image = SFWImage(named: imageName) else {
                    topOffset += preferences.preferredSize.height + preferences.verticalOffset
                    break
                }
                self.drawImage(in: context,
                               image: image,
                               preferences: preferences,
                               rotation: rotation,
                               index: index,
                               topOffset: topOffset,
                               radius: radius,
                               margins: margins)
                topOffset += preferences.preferredSize.height + preferences.verticalOffset
            case .image(let image, let preferences):
                self.drawImage(in: context,
                               image: image,
                               preferences: preferences,
                               rotation: rotation,
                               index: index,
                               topOffset: topOffset,
                               radius: radius,
                               margins: margins)
                topOffset += preferences.preferredSize.height + preferences.verticalOffset
            case .line(let preferences):
                self.drawLine(in: context,
                              preferences: preferences,
                              start: start,
                              and: end,
                              rotation: rotation,
                              index: index,
                              topOffset: topOffset,
                              radius: radius,
                              margins: margins,
                              contextPositionCorrectionOffsetDegree: contextPositionCorrectionOffsetDegree)
                topOffset += preferences.height
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
    private func drawPath(in context: CGContext, backgroundColor: SFWColor?, backgroundGradientColor: SFGradientColor?, backgroundImage: SFWImage?, start: CGFloat, and end: CGFloat, rotation:CGFloat, index: Int) {
        
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

        let gradient = backgroundGradientColor?.gradient
        
        let path = CGMutablePath()
        let center = CGPoint(x: 0, y: 0)
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: start.torad, endAngle: end.torad, clockwise: false)
        path.closeSubpath()
        
        if gradient == nil {
            context.setFillColor(pathBackgroundColor!.cgColor)
        }
        
        context.addPath(path)
        
        if gradient == nil {
            context.drawPath(using: .fill)
        }
        
        context.clip()
        
        if let gradientType = backgroundGradientColor?.type,
           let _gradient = gradient {
            switch gradientType {
            case .linear:
                let direction = backgroundGradientColor?.direction ?? .vertical
                let start = direction == .vertical ? CGPoint(x: path.boundingBox.minX, y: path.boundingBox.midY) : CGPoint(x: path.boundingBox.minX, y: path.boundingBox.minY)
                let end = direction == .vertical ? CGPoint(x: path.boundingBox.maxX, y: path.boundingBox.midY) : CGPoint(x: path.boundingBox.maxX, y: path.boundingBox.maxX)
                context.drawLinearGradient(
                    _gradient,
                    start: start,
                    end: end,
                    options: []
                )
            case .radial:
                context.drawRadialGradient(_gradient,
                                           startCenter: center,
                                           startRadius: 0,
                                           endCenter: center,
                                           endRadius: radius,
                                           options: [])
            }
        }
        
        if let backgroundImage = backgroundImage {
            self.draw(backgroundImage: backgroundImage, in: context, clipPath: path)
        }
        
        if rotation != end {
            let startPoint = CGPoint(x: (radius * (cos((end)*(CGFloat.pi/180)))), y: (radius * (sin((start)*(CGFloat.pi/180)))))
            let endPoint = CGPoint(x: (radius * (cos((start)*(CGFloat.pi/180)))), y: (radius * (sin((end)*(CGFloat.pi/180)))))
            
            let line = UIBezierPath()
            line.move(to: center)
            line.addLine(to: startPoint)
            strokeColor?.setStroke()
            line.lineWidth = strokeWidth ?? 0
            line.stroke()
            
            let line2 = UIBezierPath()
            line2.move(to: center)
            line2.addLine(to: endPoint)
            strokeColor?.setStroke()
            line2.lineWidth = strokeWidth ?? 0
            line2.stroke()
        }
        
        context.restoreGState()
    }
    
    /// Draws background image for slice
    /// - Parameters:
    ///   - backgroundImage: Background Image
    ///   - context: Context
    private func draw(backgroundImage: SFWImage, in context: CGContext, clipPath: CGPath) {

        context.saveGState()
        context.addPath(clipPath)
        context.clip()
        context.rotate(by: -contextPositionCorrectionOffsetDegree * CGFloat.pi/180)
        
        let aspectFillSize = CGSize.aspectFill(aspectRatio: backgroundImage.size, minimumSize: CGSize(width: radius, height: circularSegmentHeight))
        
        let position = CGPoint(x: -aspectFillSize.width / 2, y: -aspectFillSize.height)
        let rectangle = CGRect(x: position.x, y: position.y, width: aspectFillSize.width, height: aspectFillSize.height)
        
        switch preferences?.slicePreferences.backgroundImageContentMode {
        case .some(.bottom):
            #if os(macOS)
            backgroundImage.draw(at: position, from: NSRect(x: 0, y: 0, width: rectangle.width, height: rectangle.height), operation: .copy, fraction: 1)
            #else
            backgroundImage.draw(at: position)
            #endif
        default:
            backgroundImage.draw(in: rectangle)
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
                return self.drawCurved(text: text,
                                       in: context,
                                       preferences: preferences,
                                       rotation: rotation,
                                       index: index,
                                       topOffset: topOffset,
                                       radius: radius,
                                       sliceDegree: sliceDegree,
                                       contextPositionCorrectionOffsetDegree: contextPositionCorrectionOffsetDegree,
                                       margins: margins)
            } else {
                return self.drawHorizontal(text: text,
                                           in: context,
                                           preferences: preferences,
                                           rotation: rotation,
                                           index: index,
                                           topOffset: topOffset,
                                           radius: radius,
                                           sliceDegree: sliceDegree,
                                           margins: margins)
            }
        case .vertical:
            return self.drawVertical(text: text,
                                     in: context,
                                     preferences: preferences,
                                     rotation: rotation,
                                     index: index,
                                     topOffset: topOffset,
                                     radius: radius,
                                     sliceDegree: sliceDegree,
                                     margins: margins)
        }
    }
}
