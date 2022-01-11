//
//  Prize+ToSlice.swift
//  SwiftFortuneWheelDemoSwiftUI
//
//  Created by Sherzod Khashimov on 08/01/22.
//

import Foundation
import SwiftFortuneWheel

extension Prize {
    var sliceContentTypes: [Slice.ContentType] {
        return [Slice.ContentType.text(text: amountFormatted, preferences: .amountTextWithWhiteBlackColorsPreferences), Slice.ContentType.text(text: description, preferences: .descriptionTextWithWhiteBlackColorsPreferences), Slice.ContentType.assetImage(name: priceType.imageName, preferences: .prizeImagePreferences)]
    }

    func sliceContentTypes(isMonotone: Bool, withLine: Bool = false) -> [Slice.ContentType] {
        var sliceContentTypes = [Slice.ContentType.text(text: amountFormatted, preferences: isMonotone ? .amountTextWithBlackColorPreferences : .amountTextWithWhiteBlackColorsPreferences),
        Slice.ContentType.text(text: description, preferences: isMonotone ? .descriptionTextWithBlackColorPreferences : .descriptionTextWithWhiteBlackColorsPreferences),
        Slice.ContentType.assetImage(name: priceType.imageName, preferences: .prizeImagePreferences)]
        if withLine {
            sliceContentTypes.append(Slice.ContentType.line(preferences: .defaultPreferences))
        }
        return sliceContentTypes
    }
}


extension Array where Element == Prize {
    func slices(isMonotone: Bool = true, isWithLine: Bool = false) -> [Slice] {
        self.map({ Slice(contents: $0.sliceContentTypes(isMonotone: isMonotone, withLine: isWithLine)) })
    }
    
    func randomIndex() -> Int {
        return Int.random(in: 0..<self.count)
    }
}
