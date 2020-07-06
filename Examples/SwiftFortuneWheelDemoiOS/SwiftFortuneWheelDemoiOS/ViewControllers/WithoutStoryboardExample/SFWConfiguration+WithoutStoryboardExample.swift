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

public extension SFWConfiguration {
    static var withoutStoryboardExampleConfiguration: SFWConfiguration {
        
        let _position: SFWConfiguration.Position = .top
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: redColor)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        
        let wheeelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences,
                                                                          startPosition: _position)
                
        let configuration = SFWConfiguration(wheelPreferences: wheeelPreferences)

        return configuration
    }
}

public extension TextPreferences {
    static var withoutStoryboardExampleAmountTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont.systemFont(ofSize: 22, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          isCurved: true)
        return prefenreces
    }

    static var withoutStoryboardExampleDescriptionTextPreferences: TextPreferences {
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
