//
//  SFWConfiguration+RotationExample.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/6/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import UIKit
import SwiftFortuneWheel

private let circleStrokeWidth: CGFloat = 2
private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let secondColor = UIColor.systemGray

public extension SFWConfiguration {
    static var rotationExampleConfiguration: SFWConfiguration {
        
        let _position: SFWConfiguration.Position = .bottom
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: secondColor)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        
        let wheeelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences,
                                                                          startPosition: _position)
        
        let pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 25, height: 25),
                                                                                 position: _position,
                                                                                 verticalOffset: 30)
                
        let configuration = SFWConfiguration(wheelPreferences: wheeelPreferences, pinPreferences: pinPreferences)

        return configuration
    }
}

public extension TextPreferences {
    static var rotationExampleAmountTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont.systemFont(ofSize: 22, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        return prefenreces
    }

    static var rotationExampleDescriptionTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        return prefenreces
    }
}
