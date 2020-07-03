//
//  ImageDrawing.swift
//  SwiftFortuneWheel-iOS
//
//  Created by Sherzod Khashimov on 7/3/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation
import UIKit

/// Image drawing protocol
protocol ImageDrawing {}

extension ImageDrawing {
    /// Draws image
    /// - Parameters:
    ///   - context: context where to draw
    ///   - imageName: image  name from assets catalog
    ///   - preferences: image preferences
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - topOffset: top offset
    ///   - radius: radius
    func drawImage(in context: CGContext, imageName: String, preferences: ImagePreferences, rotation: CGFloat, index: Int, topOffset: CGFloat, radius: CGFloat) {
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
            context.rotate(by: Calc.flipRotation)
        }
        context.restoreGState()
    }
    
    
    /// Draws anchor image
    /// - Parameters:
    ///   - context: context where to draw
    ///   - imageAnchor: anchor image
    ///   - rotation: rotation degree
    ///   - index: index
    ///   - radius: radius
    ///   - sliceDegree: Slice degree
    ///   - rotationOffset: Rotation offset
    func drawAnchorImage(in context: CGContext, imageAnchor: SwiftFortuneWheelConfiguration.AnchorImage, isCentered: Bool, rotation: CGFloat, index: Int, radius: CGFloat, sliceDegree: CGFloat, rotationOffset: CGFloat) {

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
