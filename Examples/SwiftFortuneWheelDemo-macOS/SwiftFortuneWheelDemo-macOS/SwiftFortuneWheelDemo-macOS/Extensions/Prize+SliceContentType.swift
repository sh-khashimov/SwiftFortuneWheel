//
//  Price+SliceContentType.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/7/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import SwiftFortuneWheel

extension Prize {
    var sliceContentTypes: [Slice.ContentType] {
        return [Slice.ContentType.text(text: amountFormatted, preferences: .amountTextWithWhiteBlackColorsPreferences), Slice.ContentType.text(text: description, preferences: .descriptionTextWithWhiteBlackColorsPreferences), Slice.ContentType.assetImage(name: priceType.imageName, preferences: .prizeImagePreferences)]
    }

    func sliceContentTypes(isMonotone: Bool, withLine: Bool = false) -> [Slice.ContentType] {
        var sliceContentTypes = [Slice.ContentType.text(text: amountFormatted, preferences: isMonotone ? .amountTextWithBlackColorPreferences : .amountTextWithWhiteBlackColorsPreferences)]
        sliceContentTypes.append(
        Slice.ContentType.text(text: description, preferences: isMonotone ? .descriptionTextWithBlackColorPreferences : .descriptionTextWithWhiteBlackColorsPreferences))
        sliceContentTypes.append(
        Slice.ContentType.assetImage(name: priceType.imageName, preferences: .prizeImagePreferences))
        if withLine {
            sliceContentTypes.append(Slice.ContentType.line(preferences: .defaultPreferences))
        }
        return sliceContentTypes
    }
}
