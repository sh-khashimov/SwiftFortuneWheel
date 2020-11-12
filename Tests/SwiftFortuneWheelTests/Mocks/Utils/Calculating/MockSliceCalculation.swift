//
//  MockSliceCalculation.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 11/12/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftFortuneWheel

struct MockSliceCalculation: SliceCalculating {
    var slices: [Slice]
    
    func test(finishedIndex: Int, radius: CGFloat) {
        let sliceDegree = slices.count > 0 ? 360.0 / CGFloat(slices.count) : 0
        XCTAssertEqual(sliceDegree, self.sliceDegree)
        
        let theta = sliceDegree * .pi / 180
        XCTAssertEqual(theta, self.theta)
        
        let computeRadian = CGFloat(finishedIndex) * sliceDegree
        XCTAssertEqual(computeRadian, self.computeRadian(from: finishedIndex))
        
        let segmentHeight = radius * (1 - cos(sliceDegree / 2 * CGFloat.pi / 180))
        XCTAssertEqual(segmentHeight, self.segmentHeight(radius: radius))
    }
}
