//
//  SFWConfiguration+VariousWheelJackpot.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/10/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import UIKit
import SwiftFortuneWheel

public extension SFWConfiguration {
    static var variousWheelJackpotConfiguration: SFWConfiguration {
        let anchorImage = SFWConfiguration.AnchorImage(imageName: "blueAnchorImage", size: CGSize(width: 12, height: 12), verticalOffset: -22)
        
        let pin = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 13, height: 40), position: .top, verticalOffset: -25)
        
        let spin = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 20, height: 20))
        
        let sliceColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType, strokeWidth: 0, strokeColor: .white)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 15, strokeColor: .black)
        
        let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences, slicePreferences: slicePreferences, startPosition: .top, centerImageAnchor: anchorImage)
        
        let configuration = SFWConfiguration(wheelPreferences: wheelPreferences, pinPreferences: pin, spinButtonPreferences: spin)
        
        return configuration
    }
}

public extension TextPreferences {
    static var variousWheelJackpotText: TextPreferences {
        
        var font =  UIFont.systemFont(ofSize: 13, weight: .bold)
        var horizontalOffset: CGFloat = 0
        
        if let customFont = UIFont(name: "ToyBox", size: 13) {
            font = customFont
            horizontalOffset = 2
        }
        
        let textPreferences = TextPreferences(textColorType: SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white),
                                              font: font,
                                              verticalOffset: 5,
                                              horizontalOffset: horizontalOffset,
                                              orientation: .vertical,
                                              alignment: .right)
        return textPreferences
    }
}
