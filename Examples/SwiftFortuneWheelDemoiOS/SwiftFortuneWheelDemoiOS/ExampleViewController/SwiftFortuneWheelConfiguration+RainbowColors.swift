//
//  SwiftFortuneWheelConfiguration+RainbowColors.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/24/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import UIKit
import SwiftFortuneWheel

private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let circleStrokeWidth: CGFloat = 10

extension SwiftFortuneWheelConfiguration {
    static var exampleWithRainbowColorsConfiguration: SwiftFortuneWheelConfiguration {
        let configuration = SwiftFortuneWheelConfiguration(spinButtonPreferences: .exampleSpinButtonPreferences,
                                                      pinPreferences: .examplePinPreferences,
                                                      wheelPreferences: .exampleRainbowWheelPreferences)

        return configuration
    }
}

extension SwiftFortuneWheelConfiguration.WheelPreferences {
    static var exampleRainbowWheelPreferences: SwiftFortuneWheelConfiguration.WheelPreferences {
        let centerImageAnchor = SwiftFortuneWheelConfiguration.AnchorImage(imageName: "filled-circle",
                                                                size: CGSize(width: 10, height: 10),
                                                                verticalOffset: -circleStrokeWidth / 2,
                                                                tintColor: .white)
        let preferences = SwiftFortuneWheelConfiguration.WheelPreferences(circlePreferences: .exampleCirclePreferences,
                                                                     slicePreferences: .exampleRainbowSlicePreferenes,
                                                                     centerImageAnchor: centerImageAnchor)
        return preferences
    }
}

extension SwiftFortuneWheelConfiguration.SlicePreferences {
    static var exampleRainbowSlicePreferenes: SwiftFortuneWheelConfiguration.SlicePreferences {
        let backgroundColorType = SwiftFortuneWheelConfiguration.ColorType.customPatternColors(colors: [.blue, .brown, .green, .cyan, .magenta, .orange, .purple, .yellow, .systemPink, .systemTeal, .brown, .green, .cyan], defaultColor: .red)
        let preferences = SwiftFortuneWheelConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        return preferences
    }
}
