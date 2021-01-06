//
//  CGPoint+Math.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 05/01/21.
//  Copyright © 2021 SwiftFortuneWheel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension CGPoint {
    
    /// Calculates angle between point and circle center point
    /// - Parameters:
    ///   - comparisonPoint: Circle center point
    ///   - startPositionOffsetAngle: Circle rotation offset angle
    /// - Returns: Angle
    func angle(to comparisonPoint: CGPoint, startPositionOffsetAngle: CGFloat) -> CGFloat {
        
        let originX = comparisonPoint.x - x
        
        let originY = comparisonPoint.y - y
        
        let bearingRadians = atan2f(Float(originY), Float(originX))
        
        let offsetDegreeForTop: CGFloat = 90
        
        var bearingDegrees = CGFloat(bearingRadians).degrees - offsetDegreeForTop - startPositionOffsetAngle

        while bearingDegrees < 0 {
            bearingDegrees += 360
        }

        return bearingDegrees
    }
}
