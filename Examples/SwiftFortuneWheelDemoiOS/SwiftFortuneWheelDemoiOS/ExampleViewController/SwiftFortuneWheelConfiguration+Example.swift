//
//  MyProjectFortuneWheelConfiguration.swift
//  wheel
//
//  Created by Sherzod Khashimov on 6/3/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import UIKit
import SwiftFortuneWheel

private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let cyanColor = UIColor.cyan
private let circleStrokeWidth: CGFloat = 10
private let _position: SFWConfiguration.Position = .bottom

extension SFWConfiguration {
    static var exampleWithBlackCyanColorsConfiguration: SFWConfiguration {
        let configuration = SFWConfiguration(wheelPreferences: .exampleBlackCyanWheelPreferences, pinPreferences: .examplePinPreferences, spinButtonPreferences: .exampleSpinButtonPreferences)
        
        return configuration
    }
}

extension SFWConfiguration.SpinButtonPreferences {
    static var exampleSpinButtonPreferences: SFWConfiguration.SpinButtonPreferences {
        let preferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80),
                                                                               cornerRadius: 40,
                                                                               textColor: .white,
                                                                               font: .systemFont(ofSize: 20, weight: .bold),
                                                                               backgroundColor: blackColor)
        return preferences
    }
}

extension SFWConfiguration.PinImageViewPreferences {
    static var examplePinPreferences: SFWConfiguration.PinImageViewPreferences {
        let preferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 50, height: 50),
                                                                                 position: _position,
                                                                                 verticalOffset: 30)
        return preferences
    }
}

extension SFWConfiguration.WheelPreferences {
    static var exampleBlackCyanWheelPreferences: SFWConfiguration.WheelPreferences {
        let imageAnchor = SFWConfiguration.AnchorImage(imageName: "filled-circle",
                                                                     size: CGSize(width: 10, height: 10),
                                                                     verticalOffset: -circleStrokeWidth / 2,
                                                                     tintColor: .white)
        let preferences = SFWConfiguration.WheelPreferences(circlePreferences: .exampleCirclePreferences,
                                                                          slicePreferences: .exampleBlackCyanSlicePreferenes, startPosition: _position,
                                                                          imageAnchor: imageAnchor)
        return preferences
    }
}

extension SFWConfiguration.CirclePreferences {
    static var exampleCirclePreferences: SFWConfiguration.CirclePreferences {
        let preferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        return preferences
    }
}

extension SFWConfiguration.SlicePreferences {
    static var exampleBlackCyanSlicePreferenes: SFWConfiguration.SlicePreferences {
        let backgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: cyanColor)
        let preferences = SFWConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
                                                                          strokeWidth: 1,
                                                                          strokeColor: blackColor)
        return preferences
    }
}


extension ImagePreferences {
    static var prizeImagePreferences: ImagePreferences {
        let preferences = ImagePreferences(preferredSize: CGSize(width: 25, height: 25),
                                           verticalOffset: 25,
                                           flipUpsideDown: true)
        return preferences
    }
}

extension TextPreferences {
    static var amountTextWithWhiteBlackColorsPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 25,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
    
    static var descriptionTextWithWhiteBlackColorsPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 10, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          orientation: .horizontal,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
    
    
    static var amountTextWithBlackColorPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .black)
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 25,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
    
    static var descriptionTextWithBlackColorPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .black)
        let font = UIFont.systemFont(ofSize: 10, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          orientation: .horizontal,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
}


extension LinePreferences {
    static var defaultPreferences: LinePreferences {
        let colorType = SFWConfiguration.ColorType.customPatternColors(colors: [.orange, .purple, .yellow, .blue, .brown, .green, .systemPink, .systemTeal, .brown, .green, .white, .black, .magenta], defaultColor: .red)
        let preferences = LinePreferences(colorType: colorType, height: 2, verticalOffset: 0)
        return preferences
    }
}
