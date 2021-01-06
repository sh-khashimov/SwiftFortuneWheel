//
//  MockWheelMathCalculation.swift
//  SwiftFortuneWheel Tests
//
//  Created by Sherzod Khashimov on 11/12/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftFortuneWheel

#if os(macOS)
import AppKit
#else
import UIKit
#endif

class MockWheelMathCalculation: WheelMathCalculating {
    var frame: CGRect
    
    var mainFrame: CGRect!
    
    var preferences: SFWConfiguration.WheelPreferences?
    
    init(frame: CGRect, mainFrame: CGRect, preferences: SFWConfiguration.WheelPreferences? = nil) {
        self.frame = frame
        self.mainFrame = mainFrame
        self.preferences = preferences
    }
    
    func test(frame: CGRect, mainFrame: CGRect, degree: CGFloat, preferences: SFWConfiguration.WheelPreferences?) {
        
        let radius = mainFrame.height / 2.0
        XCTAssertEqual(radius, self.radius)
        
        let rotationOffset = (mainFrame.width) / 2 + abs(preferences?.layerInsets.top ?? 0)
        XCTAssertEqual(rotationOffset, self.rotationOffset)
        
        let circularSegmentHeight: CGFloat = .circularSegmentHeight(radius: radius, from: degree)
        XCTAssertEqual(circularSegmentHeight, self.circularSegmentHeight(from: degree))
    }
    
}
