//
//  SFWConfiguration+SoundExample.swift
//  SwiftFortuneWheelDemo-iOS
//
//  Created by Sherzod Khashimov on 11/11/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import UIKit
import SwiftFortuneWheel

private let circleStrokeWidth: CGFloat = 2
private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let secondColor = UIColor.systemGray

public extension SFWConfiguration {
    static var soundExampleConfiguration: SFWConfiguration {
        
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
        
        let pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 50, height: 50),
                                                                                 position: _position,
                                                                                 verticalOffset: 30)
        
        var spinButtonPreferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80))
        
        spinButtonPreferences.cornerRadius = 40
        spinButtonPreferences.textColor = .white
        spinButtonPreferences.font = .systemFont(ofSize: 20, weight: .bold)
        spinButtonPreferences.backgroundColor = blackColor
        
        let configuration = SFWConfiguration(wheelPreferences: wheeelPreferences, pinPreferences: pinPreferences, spinButtonPreferences: spinButtonPreferences)
        
        return configuration
    }
}

public extension TextPreferences {
    static var soundExampleAmountTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        return prefenreces
    }
    
    static var soundExampleDescriptionTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        return prefenreces
    }
}

extension SoundExampleViewController {
    static var soundExampleImageAnchor: SFWConfiguration.AnchorImage {
        var imageAnchor = SFWConfiguration.AnchorImage(imageName: "filled-circle",
                                                       size: CGSize(width: 10, height: 10),
                                                       verticalOffset: -circleStrokeWidth)
        
        imageAnchor.tintColor = .white
        return imageAnchor
    }
}
