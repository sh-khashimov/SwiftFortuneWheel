//
//  SFWConfiguration+VariousWheelPodium.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/10/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import UIKit
import SwiftFortuneWheel

public extension SFWConfiguration {
    static var variousWheelPodiumConfiguration: SFWConfiguration {
        
        let spin = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 64, height: 64))
        
        let sliceColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: .white)
        
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType, strokeWidth: 0, strokeColor: .white)
        
        let anchorImage = SFWConfiguration.AnchorImage(imageName: "anchorImage", size: CGSize(width: 8, height: 8), verticalOffset: -10)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 1, strokeColor: UIColor.init(red: 32/255, green: 93/255, blue: 97/255, alpha: 1))
        
        let wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences,
                                                                 slicePreferences: slicePreferences,
                                                                 startPosition: .right,
                                                                 imageAnchor: anchorImage)

        let configuration = SFWConfiguration(wheelPreferences: wheelPreferences, spinButtonPreferences: spin)

        return configuration
    }
}

public extension TextPreferences {
    static func variousWheelPodiumText(textColor: UIColor) -> TextPreferences {

        let textColorType = SFWConfiguration.ColorType.customPatternColors(colors: nil, defaultColor: textColor)
        
        var font = UIFont.systemFont(ofSize: 9, weight: .semibold)
        var horizontalOffset: CGFloat = 0
        
        if let customFont = UIFont(name: "DINCondensed-Bold", size: 12) {
            font = customFont
            horizontalOffset = -2
        }
    
        let textPreferences = TextPreferences(textColorType: textColorType,
                                                 font: font,
                                                 verticalOffset: 5,
                                                 horizontalOffset: horizontalOffset,
                                                 orientation: .vertical,
                                                 alignment: .right,
                                                 flipUpsideDown: true)
        return textPreferences
    }
}

public extension ImagePreferences {
    static var variousWheelPodiumImage: ImagePreferences {
        let imagePreferences = ImagePreferences(preferredSize: CGSize(width: 25, height: 25), verticalOffset: 5)
        return imagePreferences
    }
}
