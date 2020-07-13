//
//  MyProjectFortuneWheelConfiguration.swift
//  wheel
//
//  Created by Sherzod Khashimov on 6/3/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import AppKit
import SwiftFortuneWheel

private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let redColor = UIColor.red
private let cyanColor = UIColor.cyan
private let circleStrokeWidth: CGFloat = 10
private let _position: SFWConfiguration.Position = .bottom

extension SFWConfiguration {
    static var blackCyanColorsConfiguration: SFWConfiguration {
        
        let imageAnchor = SFWConfiguration.AnchorImage(imageName: "filled-circle",
                                                                     size: CGSize(width: 10, height: 10),
                                                                     verticalOffset: -circleStrokeWidth / 2,
                                                                     tintColor: .white)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: redColor)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: cyanColor)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                          strokeWidth: 1,
                                                                          strokeColor: .darkGray)
        
        let wheelPreference = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences, startPosition: _position,
                                                                          imageAnchor: imageAnchor)
//        wheelPreference.layerInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        
        let pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 50, height: 50),
                                                                                 position: _position,
                                                                                 verticalOffset: 30)
        
        let spinButtonPreferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80),
                                                                               cornerRadius: 40,
                                                                               textColor: .white,
                                                                               font: .systemFont(ofSize: 20, weight: .bold),
                                                                               backgroundColor: blackColor)
        
        let configuration = SFWConfiguration(wheelPreferences: wheelPreference,
                                             pinPreferences: pinPreferences,
                                             spinButtonPreferences: spinButtonPreferences)
        
        return configuration
    }
    
    static var rainbowColorsConfiguration: SFWConfiguration {

        let position: SFWConfiguration.Position = .bottom
        
        let centerImageAnchor = SFWConfiguration.AnchorImage(imageName: "filled-circle",
                                                                size: CGSize(width: 10, height: 10),
                                                                verticalOffset: -circleStrokeWidth / 2,
                                                                tintColor: .white)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.customPatternColors(colors: [.blue, .brown, .green, .cyan, .magenta, .orange, .purple, .yellow, .systemPink, .systemTeal, .brown, .green, .cyan], defaultColor: .red)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        
        let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences,
                                                                          startPosition: position,
                                                                          centerImageAnchor: centerImageAnchor)
        
        let pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 50, height: 50),
                                                                                 position: position,
                                                                                 verticalOffset: 30)
        
        let spinButtonPreferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80),
                                                                               cornerRadius: 40,
                                                                               textColor: .white,
                                                                               font: .systemFont(ofSize: 20, weight: .bold),
                                                                               backgroundColor: blackColor)
        
        let configuration = SFWConfiguration(wheelPreferences: wheelPreferences,
                                             pinPreferences: pinPreferences,
                                             spinButtonPreferences: spinButtonPreferences)

        return configuration
    }
}

extension ImagePreferences {
    static var prizeImagePreferences: ImagePreferences {
        let preferences = ImagePreferences(preferredSize: CGSize(width: 25, height: 25),
                                           verticalOffset: 10,
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
                                          verticalOffset: 10,
                                          orientation: .horizontal,
                                          flipUpsideDown: true,
                                          isCurved: false)
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
        let preferences = LinePreferences(colorType: colorType, height: 2, verticalOffset: 10)
        return preferences
    }
}
