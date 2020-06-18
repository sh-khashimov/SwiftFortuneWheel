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

extension SwiftFortuneWheelConfiguration {
    static var exampleWithBlackCyanColorsConfiguration: SwiftFortuneWheelConfiguration {
        let configuration = SwiftFortuneWheelConfiguration(spinButtonPreferences: .exampleSpinButtonPreferences,
                                                      pinPreferences: .examplePinPreferences,
                                                      wheelPreferences: .exampleBlackCyanWheelPreferences)

        return configuration
    }

    static var exampleWithRainbowColorsConfiguration: SwiftFortuneWheelConfiguration {
        let configuration = SwiftFortuneWheelConfiguration(spinButtonPreferences: .exampleSpinButtonPreferences,
                                                      pinPreferences: .examplePinPreferences,
                                                      wheelPreferences: .exampleRainbowWheelPreferences)

        return configuration
    }
}

extension SwiftFortuneWheelConfiguration.SpinButtonPreferences {
    static var exampleSpinButtonPreferences: SwiftFortuneWheelConfiguration.SpinButtonPreferences {
        let preferences = SwiftFortuneWheelConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80),
                                                                                    cornerRadius: 40,
                                                                                    textColor: .white,
                                                                                    font: .systemFont(ofSize: 20, weight: .bold),
                                                                                    backgroundColor: blackColor)
        return preferences
    }
}

extension SwiftFortuneWheelConfiguration.PinImageViewPreferences {
    static var examplePinPreferences: SwiftFortuneWheelConfiguration.PinImageViewPreferences {
        let preferences = SwiftFortuneWheelConfiguration.PinImageViewPreferences(size: CGSize(width: 50, height: 50),
                                                                            position: .bottom,
                                                                            verticalOffset: 30)
        return preferences
    }
}

extension SwiftFortuneWheelConfiguration.WheelPreferences {
    static var exampleBlackCyanWheelPreferences: SwiftFortuneWheelConfiguration.WheelPreferences {
        let imageAnchor = SwiftFortuneWheelConfiguration.AnchorImage(imageName: "filled-circle",
                                                                size: CGSize(width: 10, height: 10),
                                                                verticalOffset: -circleStrokeWidth / 2,
                                                                tintColor: .white)
        let preferences = SwiftFortuneWheelConfiguration.WheelPreferences(circlePreferences: .exampleCirclePreferences,
                                                                     slicePreferences: .exampleBlackCyanSlicePreferenes,
                                                                     imageAnchor: imageAnchor)
        return preferences
    }

    static var exampleRainbowWheelPreferences: SwiftFortuneWheelConfiguration.WheelPreferences {
        let centerImageAnchor = SwiftFortuneWheelConfiguration.AnchorImage(imageName: "filled-circle",
                                                                size: CGSize(width: 10, height: 10),
                                                                verticalOffset: -circleStrokeWidth / 2,
                                                                tintColor: .white)
        let preferences = SwiftFortuneWheelConfiguration.WheelPreferences(circlePreferences: .exampleCirclePreferences,
                                                                     slicePreferences: .exampleRainbowSlicePreferenes,
                                                                     centerImageAnchor: centerImageAnchor)
        return preferences
    }
}

extension SwiftFortuneWheelConfiguration.CirclePreferences {
    static var exampleCirclePreferences: SwiftFortuneWheelConfiguration.CirclePreferences {
        let preferences = SwiftFortuneWheelConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                      strokeColor: blackColor)
        return preferences
    }
}

extension SwiftFortuneWheelConfiguration.SlicePreferences {
    static var exampleBlackCyanSlicePreferenes: SwiftFortuneWheelConfiguration.SlicePreferences {
        let backgroundColorType = SwiftFortuneWheelConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: cyanColor)
        let preferences = SwiftFortuneWheelConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        return preferences
    }

    static var exampleRainbowSlicePreferenes: SwiftFortuneWheelConfiguration.SlicePreferences {
        let backgroundColorType = SwiftFortuneWheelConfiguration.ColorType.customPatternColors(colors: [.blue, .brown, .green, .cyan, .magenta, .orange, .purple, .yellow, .systemPink, .systemTeal, .brown, .green, .cyan], defaultColor: .red)
        let preferences = SwiftFortuneWheelConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
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
        let textColorType = SwiftFortuneWheelConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          preferedFontSize: 20,
                                          verticalOffset: 25,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }

    static var descriptionTextWithWhiteBlackColorsPreferences: TextPreferences {
        let textColorType = SwiftFortuneWheelConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 10, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          preferedFontSize: 10,
                                          verticalOffset: 10,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }


    static var amountTextWithBlackColorPreferences: TextPreferences {
        let textColorType = SwiftFortuneWheelConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .black)
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          preferedFontSize: 20,
                                          verticalOffset: 25,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }

    static var descriptionTextWhiteBlackColorPreferences: TextPreferences {
        let textColorType = SwiftFortuneWheelConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .black)
        let font = UIFont.systemFont(ofSize: 10, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          preferedFontSize: 10,
                                          verticalOffset: 10,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
}


extension LinePreferences {
    static var defaultPreferences: LinePreferences {
        let colorType = SwiftFortuneWheelConfiguration.ColorType.customPatternColors(colors: [.orange, .purple, .yellow, .blue, .brown, .green, .systemPink, .systemTeal, .brown, .green, .white, .black, .magenta], defaultColor: .red)
        let preferences = LinePreferences(colorType: colorType, height: 2, verticalOffset: 0)
        return preferences
    }
}
