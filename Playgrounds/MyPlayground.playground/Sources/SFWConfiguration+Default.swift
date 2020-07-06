import Foundation
import UIKit
import SwiftFortuneWheel

private let circleStrokeWidth: CGFloat = 2
private let blackColor = UIColor(white: 51.0 / 255.0, alpha: 1.0)
private let cyanColor = UIColor.cyan

public extension SFWConfiguration {
    static var defaultConfiguration: SFWConfiguration {
        let configuration = SFWConfiguration(wheelPreferences: .defaultWheelPreferences,
                                             pinPreferences: .defaultPinPreferences,
                                             spinButtonPreferences: .defaultSpinButtonPreferences)

        return configuration
    }
}

public extension SFWConfiguration.SpinButtonPreferences {
    static var defaultSpinButtonPreferences: SFWConfiguration.SpinButtonPreferences {
        let preferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80),
                                                                                    cornerRadius: 40,
                                                                                    textColor: .white,
                                                                                    font: .systemFont(ofSize: 20, weight: .bold),
                                                                                    backgroundColor: blackColor)
        return preferences
    }
}

public extension SFWConfiguration.PinImageViewPreferences {
    static var defaultPinPreferences: SFWConfiguration.PinImageViewPreferences {
        let preferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 12, height: 24),
                                                                            position: .bottom,
                                                                            verticalOffset: 30)
        return preferences
    }
}

public extension SFWConfiguration.WheelPreferences {
    static var defaultWheelPreferences: SFWConfiguration.WheelPreferences {
        let preferences = SFWConfiguration.WheelPreferences(circlePreferences: .defaultCirclePreferences,
                                                            slicePreferences: .defaultSlicePreferenes,
                                                            startPosition: .bottom)
        return preferences
    }
}

public extension SFWConfiguration.CirclePreferences {
    static var defaultCirclePreferences: SFWConfiguration.CirclePreferences {
        let preferences = SFWConfiguration.CirclePreferences(strokeWidth: circleStrokeWidth,
                                                                           strokeColor: blackColor)
        return preferences
    }
}

public extension SFWConfiguration.SlicePreferences {
    static var defaultSlicePreferenes: SFWConfiguration.SlicePreferences {
        let backgroundColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: blackColor, oddColor: cyanColor)
        let preferences = SFWConfiguration.SlicePreferences(backgroundColorType: backgroundColorType,
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
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 22, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          isCurved: true)
        return prefenreces
    }

    static var descriptionTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10,
                                          orientation: .horizontal,
                                          lineBreak: .truncateTail,
                                          alignment: . center,
                                          lines: 0,
                                          spacing: 5,
                                          flipUpsideDown: true,
                                          isCurved: true)
        return prefenreces
    }
}
