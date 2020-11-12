//
//  CalculationTests.swift
//  SwiftFortuneWheel Tests
//
//  Created by Sherzod Khashimov on 11/12/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import XCTest
@testable import SwiftFortuneWheel

#if os(macOS)
import AppKit
#else
import UIKit
#endif


class CalculationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testCalculation() {
        XCTAssertEqual(.pi, Calc.flipRotation)
        
        let degree: CGFloat = -200
        let radius: CGFloat = 10
        
        let torad = degree * .pi / 180.0
        XCTAssertEqual(torad, Calc.torad(degree))
        
        let circularSegmentHeight = 2 * radius * sin(degree / 2.0 * CGFloat.pi / 180)
        XCTAssertEqual(circularSegmentHeight, Calc.circularSegmentHeight(radius: radius, from: degree))
        
        let _radius = circularSegmentHeight / (2 * sin(degree / 2.0 * CGFloat.pi / 180))
        XCTAssertEqual(_radius, Calc.radius(circularSegmentHeight: circularSegmentHeight, from: degree))
        
    }
    
    func testWheelMathCalculation() {
        var frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 400)
        var mainFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 800)
        let degree: CGFloat = 60
        
        wheelMathCalculation(frame: frame, mainFrame: mainFrame, degree: degree, preferences: nil)
        
        frame = CGRect.zero
        mainFrame = CGRect.zero
        let preferences = SFWConfiguration.WheelPreferences(circlePreferences: SFWConfiguration.CirclePreferences(), slicePreferences: SFWConfiguration.SlicePreferences(backgroundColorType: .customPatternColors(colors: nil, defaultColor: .black)), startPosition: .bottom)
        
        wheelMathCalculation(frame: frame, mainFrame: mainFrame, degree: degree, preferences: preferences)
    }
    
    private func wheelMathCalculation(frame: CGRect, mainFrame: CGRect, degree: CGFloat, preferences: SFWConfiguration.WheelPreferences?) {
        let wheelMathCalculation = MockWheelMathCalculation(frame: frame, mainFrame: mainFrame, preferences: preferences)
        
        wheelMathCalculation.test(frame: frame, mainFrame: mainFrame, degree: degree, preferences: preferences)
    }
    
    
    func testSliceCalculation() {
        var slices: [Slice] = []
        // First testing no slices
        sliceCalculation(slices: slices, finishedIndex: 0, radius: 740)
        
        for _ in 1...10 {
            // Doesn't matter what type of slice it's
            let lineSlice = Slice(contents: [Slice.ContentType.line(preferences: LinePreferences(colorType: .customPatternColors(colors: nil, defaultColor: .black)))])
            slices.append(lineSlice)
        }
        
        // testing with slices
        sliceCalculation(slices: slices, finishedIndex: slices.count-1, radius: 200)
        sliceCalculation(slices: slices, finishedIndex: 0, radius: -600)
        sliceCalculation(slices: slices, finishedIndex: slices.count+1, radius: 700)
    }
    
    private func sliceCalculation(slices: [Slice], finishedIndex: Int, radius: CGFloat) {
        let sliceCalculation = MockSliceCalculation(slices: slices)
        
        sliceCalculation.test(finishedIndex: finishedIndex, radius: radius)
    }

}
