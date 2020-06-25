import Foundation
import UIKit
import SwiftFortuneWheel

private let circleStrokeWidth: CGFloat = 2
private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let cyanColor = UIColor.cyan

public extension SwiftFortuneWheelConfiguration {
    static var defaultConfiguration: SwiftFortuneWheelConfiguration {
        let configuration = SwiftFortuneWheelConfiguration(spinButtonPreferences: .defaultSpinButtonPreferences,
                                                      pinPreferences: .defaultPinPreferences,
                                                      wheelPreferences: .defaultWheelPreferences)

        return configuration
    }
}

public extension SwiftFortuneWheelConfiguration.SpinButtonPreferences {
    static var defaultSpinButtonPreferences: SwiftFortuneWheelConfiguration.SpinButtonPreferences {
        let preferences = SwiftFortuneWheelConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80),
                                                                                    cornerRadius: 40,
                                                                                    textColor: .white,
                                                                                    font: .systemFont(ofSize: 20, weight: .bold),
                                                                                    backgroundColor: blackColor)
        return preferences
    }
}

public extension SwiftFortuneWheelConfiguration.PinImageViewPreferences {
    static var defaultPinPreferences: SwiftFortuneWheelConfiguration.PinImageViewPreferences {
        let preferences = SwiftFortuneWheelConfiguration.PinImageViewPreferences(size: CGSize(width: 12, height: 24),
                                                                            position: .bottom,
                                                                            verticalOffset: 30)
        return preferences
    }
}

public extension SwiftFortuneWheelConfiguration.WheelPreferences {
    static var defaultWheelPreferences: SwiftFortuneWheelConfiguration.WheelPreferences {
        let preferences = SwiftFortuneWheelConfiguration.WheelPreferences(circlePreferences: .defaultCirclePreferences,
                                                                     slicePreferences: .defaultSlicePreferenes)
        return preferences
    }
}

public extension SwiftFortuneWheelConfiguration.CirclePreferences {
    static var defaultCirclePreferences: SwiftFortuneWheelConfiguration.CirclePreferences {
        let preferences = SwiftFortuneWheelConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        return preferences
    }
}

public extension SwiftFortuneWheelConfiguration.SlicePreferences {
    static var defaultSlicePreferenes: SwiftFortuneWheelConfiguration.SlicePreferences {
        let backgroundColorType = SwiftFortuneWheelConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: cyanColor)
        let preferences = SwiftFortuneWheelConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
                                                                            strokeWidth: 1,
                                                                            strokeColor: blackColor)
        return preferences
    }
}


public extension ImagePreferences {
    static var prizeImagePreferences: ImagePreferences {
        let preferences = ImagePreferences(preferredSize: CGSize(width: 25, height: 25),
                                           verticalOffset: 27,
                                           flipUpsideDown: true)
        return preferences
    }
}

public extension TextPreferences {
    static var amountTextPreferences: TextPreferences {
        let textColorType = SwiftFortuneWheelConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 22, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          preferedFontSize: 20,
                                          verticalOffset: 10,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }

    static var descriptionTextPreferences: TextPreferences {
        let textColorType = SwiftFortuneWheelConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          preferedFontSize: 10,
                                          verticalOffset: 3,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
}
