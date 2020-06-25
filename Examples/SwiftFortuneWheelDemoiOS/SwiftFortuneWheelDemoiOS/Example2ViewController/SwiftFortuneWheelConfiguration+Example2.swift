//
//  SwiftFortuneWheelConfiguration+Example2.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/25/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import UIKit
import SwiftFortuneWheel

private let circleStrokeWidth: CGFloat = 2
private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let redColor = UIColor.red

public extension SwiftFortuneWheelConfiguration {
    static var example2Configuration: SwiftFortuneWheelConfiguration {
        let configuration = SwiftFortuneWheelConfiguration(spinButtonPreferences: .example2SpinButtonPreferences,
                                                      pinPreferences: .example2PinPreferences,
                                                      wheelPreferences: .example2WheelPreferences)

        return configuration
    }
}

public extension SwiftFortuneWheelConfiguration.SpinButtonPreferences {
    static var example2SpinButtonPreferences: SwiftFortuneWheelConfiguration.SpinButtonPreferences {
        let preferences = SwiftFortuneWheelConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80),
                                                                                    cornerRadius: 40,
                                                                                    textColor: .white,
                                                                                    font: .systemFont(ofSize: 20, weight: .bold),
                                                                                    backgroundColor: blackColor)
        return preferences
    }
}

public extension SwiftFortuneWheelConfiguration.PinImageViewPreferences {
    static var example2PinPreferences: SwiftFortuneWheelConfiguration.PinImageViewPreferences {
        let preferences = SwiftFortuneWheelConfiguration.PinImageViewPreferences(size: CGSize(width: 12, height: 24),
                                                                            position: .top,
                                                                            verticalOffset: 30)
        return preferences
    }
}

public extension SwiftFortuneWheelConfiguration.WheelPreferences {
    static var example2WheelPreferences: SwiftFortuneWheelConfiguration.WheelPreferences {
        let preferences = SwiftFortuneWheelConfiguration.WheelPreferences(circlePreferences: .example2CirclePreferences,
                                                                     slicePreferences: .example2SlicePreferenes)
        return preferences
    }
}

public extension SwiftFortuneWheelConfiguration.CirclePreferences {
    static var example2CirclePreferences: SwiftFortuneWheelConfiguration.CirclePreferences {
        let preferences = SwiftFortuneWheelConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        return preferences
    }
}

public extension SwiftFortuneWheelConfiguration.SlicePreferences {
    static var example2SlicePreferenes: SwiftFortuneWheelConfiguration.SlicePreferences {
        let backgroundColorType = SwiftFortuneWheelConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: redColor)
        let preferences = SwiftFortuneWheelConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        return preferences
    }
}

public extension TextPreferences {
    static var example2AmountTextPreferences: TextPreferences {
        let textColorType = SwiftFortuneWheelConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont.systemFont(ofSize: 22, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          isCurved: true)
        return prefenreces
    }

    static var example2DescriptionTextPreferences: TextPreferences {
        let textColorType = SwiftFortuneWheelConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          orientation: .vertical,
                                          flipUpsideDown: false,
                                          isCurved: false)
        return prefenreces
    }
}
