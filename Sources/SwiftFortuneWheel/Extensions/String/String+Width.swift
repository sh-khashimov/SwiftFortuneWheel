//
//  String+Width.swift
//  SwiftFortuneWheel-iOS
//
//  Created by Sherzod Khashimov on 6/27/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /// Avalilable width for text with specified font
    /// - Parameter font: Font
    /// - Returns: Text width
    func width(by font: UIFont) -> CGFloat {
        var textWidth: CGFloat = 0
        for element in self {
            let characterString = String(element)
            let letterSize = characterString.size(withAttributes: [.font: font])
            textWidth += letterSize.width
        }
        return textWidth + 1
    }
}
