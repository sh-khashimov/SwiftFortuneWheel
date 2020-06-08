//
//  SliceCalculating.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation
import UIKit

/// Slice calculation protocol
protocol SliceCalculating {
    /// Slices
    var slices: [Slice] { get set }
}

extension SliceCalculating {
    /// Slice degree
    var sliceDegree: CGFloat {
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
}
