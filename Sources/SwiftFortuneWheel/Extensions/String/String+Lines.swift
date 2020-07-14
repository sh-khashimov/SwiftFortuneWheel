//
//  String+Lines.swift
//  SwiftFortuneWheel-iOS
//
//  Created by Sherzod Khashimov on 6/27/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension String {
    /// Сounts the right amount of lines for text
    /// - Parameters:
    ///   - font: Font
    ///   - spacing: Spacing between lines
    /// - Returns: Right amount of lines for text
    func linesCount(for font: SFWFont, spacing: CGFloat) -> Int {
        let width = self.width(by: font)
        return max(1, Int((width / (font.pointSize + spacing)).rounded(.down)))
    }
}
