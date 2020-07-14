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

private let blackColor = NSColor(white: 51.0 / 255.0, alpha: 1.0)
private let borderColor = #colorLiteral(red: 0.09409319609, green: 0.1333444715, blue: 0.1764436364, alpha: 1)
private let darkGrayColor = #colorLiteral(red: 0.1490027308, green: 0.1490304172, blue: 0.148996681, alpha: 1)
private let cyanColor = NSColor.cyan
private let circleStrokeWidth: CGFloat = 10
private let _position: SFWConfiguration.Position = .bottom

extension SFWConfiguration {
    static var blackCyanColorsConfiguration: SFWConfiguration {
        
        let imageAnchor = SFWConfiguration.AnchorImage(imageName: "filled-circle",
                                                                     size: CGSize(width: 10, height: 10),
                                                                     verticalOffset: -circleStrokeWidth / 2,
                                                                     tintColor: .white)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: borderColor)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: darkGrayColor, oddColor: cyanColor)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                          strokeWidth: 1,
                                                                          strokeColor: borderColor)
        
        let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences, startPosition: _position,
                                                                          imageAnchor: imageAnchor)
        
        let pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 50, height: 50),
                                                                                 position: _position,
                                                                                 verticalOffset: 30)
        
        let spinButtonPreferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 60, height: 60),
                                                                               cornerRadius: 30,
                                                                               textColor: .white,
                                                                               font: .systemFont(ofSize: 16, weight: .bold),
                                                                               backgroundColor: darkGrayColor)
        
        var configuration = SFWConfiguration(wheelPreferences: wheelPreferences,
                                             pinPreferences: pinPreferences,
                                             spinButtonPreferences: spinButtonPreferences)
        
        configuration.alignmentRectInsets = NSEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        
        return configuration
    }
    
    static var rainbowColorsConfiguration: SFWConfiguration {

        let position: SFWConfiguration.Position = .bottom
        
        let centerImageAnchor = SFWConfiguration.AnchorImage(imageName: "filled-circle",
                                                                size: CGSize(width: 10, height: 10),
                                                                verticalOffset: -circleStrokeWidth / 2,
                                                                tintColor: .white)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: borderColor)
        
        let sliceBackgroundColorType = SFWConfiguration.ColorType.customPatternColors(colors: [.blue, .brown, .green, .cyan, .magenta, .orange, .purple, .yellow, .systemPink, .systemTeal, .brown, .green, .cyan], defaultColor: .red)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceBackgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: borderColor)
        
        let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                          slicePreferences: slicePreferences,
                                                                          startPosition: position,
                                                                          centerImageAnchor: centerImageAnchor)
        
        let pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 25, height: 25),
                                                                                 position: position,
                                                                                 verticalOffset: 25)
        
        let spinButtonPreferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 60, height: 60),
                                                                               cornerRadius: 30,
                                                                               textColor: .white,
                                                                               font: .systemFont(ofSize: 16, weight: .bold),
                                                                               backgroundColor: darkGrayColor)
        
        var configuration = SFWConfiguration(wheelPreferences: wheelPreferences,
                                             pinPreferences: pinPreferences,
                                             spinButtonPreferences: spinButtonPreferences)
                                             
        configuration.alignmentRectInsets = NSEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)

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
        let font = NSFont.systemFont(ofSize: 20, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          orientation: .horizontal,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
    
    static var descriptionTextWithWhiteBlackColorsPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = NSFont.systemFont(ofSize: 10, weight: .bold)
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
        let font = NSFont.systemFont(ofSize: 20, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
    
    static var descriptionTextWithBlackColorPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .black)
        let font = NSFont.systemFont(ofSize: 10, weight: .bold)
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
