//
//  SFWConfiguration+VariousWheelSpike.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/8/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import UIKit
import SwiftFortuneWheel

private let circleStrokeWidth: CGFloat = 3
private let grayColor = UIColor.init(red: 230/255, green: 231/255, blue: 232/255, alpha: 1)
private let redColor = UIColor.red

public extension SFWConfiguration {
    static var variousWheelSpikeConfiguration: SFWConfiguration {
        
        let _position: SFWConfiguration.Position = .top
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                   strokeColor: grayColor)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .gray, oddColor: .darkGray)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                            strokeWidth: 0,
                                                                            strokeColor: .clear)
        
        
        let imageAnchor = SFWConfiguration.AnchorImage(imageName: "triangleAnchor",
                                                                     size: CGSize(width: 15, height: 7),
                                                                     verticalOffset: -10,
                                                                     tintColor: .white)
        
        
        let imageCenterAnchor = SFWConfiguration.AnchorImage(imageName: "ovalAnchor",
                                                                     size: CGSize(width: 8, height: 8),
                                                                     verticalOffset: -14)
        
        let wheeelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences,
                                                                          startPosition: _position,
                                                                          imageAnchor: imageAnchor,
                                                                          centerImageAnchor: imageCenterAnchor)
        
        let pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 101, height: 83),
                                                                      position: _position, horizontalOffset: 15, verticalOffset: (250 - 83) / 2 + 5)
                
        let configuration = SFWConfiguration(wheelPreferences: wheeelPreferences, pinPreferences: pinPreferences)

        return configuration
    }
}

public extension TextPreferences {
    static func variousWheelSpikeTextPreferences(fontSize: CGFloat, textColor: UIColor) -> TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: textColor)
        let font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          isCurved: true)
        return prefenreces
    }
}

public extension LinePreferences {
    static func variousWheelSpikeLinePreferences(color: UIColor, verticalOffset: CGFloat) -> LinePreferences {
        let preferences = LinePreferences(colorType: SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: color), height: 3, verticalOffset: verticalOffset)
        return preferences
    }
}
