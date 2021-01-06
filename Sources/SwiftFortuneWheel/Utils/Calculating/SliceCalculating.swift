//
//  SliceCalculating.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation
import CoreGraphics

/// Slice calculation protocol
protocol SliceCalculating {
    /// Slices
    var slices: [Slice] { get set }
}

extension SliceCalculating {
    /// Slice degree
    var sliceDegree: CGFloat {
        guard slices.count > 0 else {
            return 0
        }
        return 360.0 / CGFloat(slices.count)
    }
    
    /// Theta
    var theta: CGFloat {
        return sliceDegree * .pi / 180.0
    }
    
    /// Calculates radion for index
    /// - Parameter finishIndex: index
    /// - Returns: radian
    func computeRadian(from finishIndex:Int) -> CGFloat {
        return CGFloat(finishIndex) * sliceDegree
    }
    
    /// Calculates index for selected angle
    /// - Parameter angle: Angle degree
    /// - Returns: Index
    func index(fromAngle angle: CGFloat) -> Int {
        guard sliceDegree > 0 else { return 0 }
        
        /// readjust angle for slice center position
        var _angle = angle + sliceDegree / 2
        
        if _angle > 360 {
            _angle -= 360
        }
        
        /// Index for angle
        let index = Int((_angle / sliceDegree).rounded(.down))
        
        return min(index, slices.count - 1)
    }
    
    /// Segment height
    /// - Parameter radius: Radius
    /// - Returns: Segment height
    func segmentHeight(radius: CGFloat) -> CGFloat {
        return radius * (1 - cos(sliceDegree / 2 * CGFloat.pi / 180))
    }
}
