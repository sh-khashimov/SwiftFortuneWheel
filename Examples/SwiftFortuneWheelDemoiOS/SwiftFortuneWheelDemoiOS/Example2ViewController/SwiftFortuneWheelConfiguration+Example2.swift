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
private let _position: SFWConfiguration.Position = .top

public extension SFWConfiguration {
    static var example2Configuration: SFWConfiguration {
        let configuration = SFWConfiguration(wheelPreferences: .example2WheelPreferences, pinPreferences: .example2PinPreferences, spinButtonPreferences: .example2SpinButtonPreferences)

        return configuration
    }
}

public extension SFWConfiguration.SpinButtonPreferences {
    static var example2SpinButtonPreferences: SFWConfiguration.SpinButtonPreferences {
        let preferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80),
                                                                                    cornerRadius: 40,
                                                                                    textColor: .white,
                                                                                    font: .systemFont(ofSize: 20, weight: .bold),
                                                                                    backgroundColor: blackColor)
        return preferences
    }
}

public extension SFWConfiguration.PinImageViewPreferences {
    static var example2PinPreferences: SFWConfiguration.PinImageViewPreferences {
        let preferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 12, height: 24),
                                                                            position: _position,
                                                                            verticalOffset: 30)
        return preferences
    }
}

public extension SFWConfiguration.WheelPreferences {
    static var example2WheelPreferences: SFWConfiguration.WheelPreferences {
        let preferences = SFWConfiguration.WheelPreferences(circlePreferences: .example2CirclePreferences,
                                                                          slicePreferences: .example2SlicePreferenes, startPosition: _position)
        return preferences
    }
}

public extension SFWConfiguration.CirclePreferences {
    static var example2CirclePreferences: SFWConfiguration.CirclePreferences {
        let preferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        return preferences
    }
}

public extension SFWConfiguration.SlicePreferences {
    static var example2SlicePreferenes: SFWConfiguration.SlicePreferences {
        let backgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: redColor)
        let preferences = SFWConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        return preferences
    }
}

public extension TextPreferences {
    static var example2AmountTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont.systemFont(ofSize: 22, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          isCurved: true)
        return prefenreces
    }

    static var example2DescriptionTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
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
