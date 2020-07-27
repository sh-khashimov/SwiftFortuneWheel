import Foundation
import UIKit
import SwiftFortuneWheel

private let circleStrokeWidth: CGFloat = 10
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
        var preferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 80, height: 80))
        preferences.cornerRadius = 40
        preferences.textColor = .white
        preferences.font = .systemFont(ofSize: 20, weight: .bold)
        preferences.backgroundColor = blackColor
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
                                                                            strokeWidth: 5,
                                                                            strokeColor: .red)
        return preferences
    }
}


public extension ImagePreferences {
    static var prizeImagePreferences: ImagePreferences {
        var preferences = ImagePreferences(preferredSize: CGSize(width: 25, height: 25),
                                           verticalOffset: 27)
        preferences.flipUpsideDown = true
        return preferences
    }
}

public extension TextPreferences {
    static var amountTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 22, weight: .bold)
        var preferences = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        
        preferences.isCurved = true
        return preferences
    }

    static var descriptionTextPreferences: TextPreferences {
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: blackColor)
        let font = UIFont.systemFont(ofSize: 12, weight: .bold)
        var preferences = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        preferences.maxWidth = 12
        preferences.orientation = .horizontal
        preferences.lineBreakMode = .characterWrap
        preferences.alignment = .center
        preferences.numberOfLines = 0
        preferences.spacing = 5
        preferences.flipUpsideDown = true
        preferences.isCurved = true
        return preferences
    }
}
