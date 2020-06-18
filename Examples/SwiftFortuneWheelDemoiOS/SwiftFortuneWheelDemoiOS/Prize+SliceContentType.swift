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
        return [Slice.ContentType.text(text: amountFormatted, preferenes: .amountTextWithWhiteBlackColorsPreferences), Slice.ContentType.text(text: description, preferenes: .descriptionTextWithWhiteBlackColorsPreferences), Slice.ContentType.image(name: priceType.imageName, preferenes: .prizeImagePreferences)]
    }

    func sliceContentTypes(isMonotone: Bool, withLine: Bool = false) -> [Slice.ContentType] {
        var sliceContentTypes = [Slice.ContentType.text(text: amountFormatted, preferenes: isMonotone ? .amountTextWithBlackColorPreferences : .amountTextWithWhiteBlackColorsPreferences),
        Slice.ContentType.text(text: description, preferenes: isMonotone ? .descriptionTextWhiteBlackColorPreferences : .descriptionTextWithWhiteBlackColorsPreferences),
        Slice.ContentType.image(name: priceType.imageName, preferenes: .prizeImagePreferences)]
        if withLine {
            sliceContentTypes.append(Slice.ContentType.line(preferenes: .defaultPreferences))
        }
        return sliceContentTypes
    }
}
