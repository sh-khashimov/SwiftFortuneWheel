//
//  ShapeDrawing.swift
//  SwiftFortuneWheel-iOS
//
//  Created by Sherzod Khashimov on 7/3/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Shape drawing protocol
protocol ShapeDrawing {}

extension ShapeDrawing {
    /// Draws rectangle
    /// - Parameters:
    ///   - context: context where to draw
    ///   - rotation: rotation degree
    ///   - radius: radius
    func drawRectangle(in context: CGContext, rotation: CGFloat, radius: CGFloat) {
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
    ///   - radius: radius
    ///   - margins: content margins   
    ///   - contextPositionCorrectionOffsetDegree: Context position correction offset degree
    func drawLine(in context: CGContext, preferences: LinePreferences, start: CGFloat, and end: CGFloat, rotation: CGFloat, index: Int, topOffset: CGFloat, radius: CGFloat, margins: SFWConfiguration.Margins, contextPositionCorrectionOffsetDegree: CGFloat) {
        
        let strokeColor = preferences.strokeColor(for: index)
        
        context.saveGState()
        context.rotate(by: (rotation - contextPositionCorrectionOffsetDegree) * CGFloat.pi/180)
        
        let strokeWidth = preferences.height
        
        let yPosition = radius - preferences.verticalOffset - topOffset - margins.top
        let center = CGPoint(x: 0, y: 0)
        
        let path = CGMutablePath()
        path.addArc(center: center, radius: -yPosition, startAngle: start.torad, endAngle: end.torad, clockwise: false)
        context.setStrokeColor(strokeColor.cgColor)
        context.setFillColor(SFWColor.clear.cgColor)
        context.setLineWidth(strokeWidth)
        context.addPath(path)
        context.strokePath()
        
        context.restoreGState()
    }
}
