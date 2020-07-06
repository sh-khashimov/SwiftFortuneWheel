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
private let position: SFWConfiguration.Position = .bottom

extension SFWConfiguration {
    static var exampleWithRainbowColorsConfiguration: SFWConfiguration {
        let configuration = SFWConfiguration(wheelPreferences: .exampleRainbowWheelPreferences, pinPreferences: .examplePinPreferences, spinButtonPreferences: .exampleSpinButtonPreferences)

        return configuration
    }
}

extension SFWConfiguration.WheelPreferences {
    static var exampleRainbowWheelPreferences: SFWConfiguration.WheelPreferences {
        let centerImageAnchor = SFWConfiguration.AnchorImage(imageName: "filled-circle",
                                                                size: CGSize(width: 10, height: 10),
                                                                verticalOffset: -circleStrokeWidth / 2,
                                                                tintColor: .white)
        let preferences = SFWConfiguration.WheelPreferences(circlePreferences: .exampleCirclePreferences,
                                                                          slicePreferences: .exampleRainbowSlicePreferenes, startPosition: position,
                                                                     centerImageAnchor: centerImageAnchor)
        return preferences
    }
}

extension SFWConfiguration.SlicePreferences {
    static var exampleRainbowSlicePreferenes: SFWConfiguration.SlicePreferences {
        let backgroundColorType = SFWConfiguration.ColorType.customPatternColors(colors: [.blue, .brown, .green, .cyan, .magenta, .orange, .purple, .yellow, .systemPink, .systemTeal, .brown, .green, .cyan], defaultColor: .red)
        let preferences = SFWConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        return preferences
    }
}
