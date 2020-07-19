//
//  String+Crop.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/6/20.
// 
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension String {
    /// Crops string by specified width and font
    /// - Parameters:
    ///   - width: Maximum width for string
    ///   - font: Font for string
    /// - Returns: Cropped string
    func crop(by width: CGFloat, font: SFWFont) -> String {
        var croppedText = ""
        var textWidth: CGFloat = 0
        
        for element in self {
            let characterString = String(element)
            let letterSize = characterString.size(withAttributes: [.font: font])
            textWidth += letterSize.width
            guard textWidth < width else { break }
            croppedText += characterString
        }
        
        return croppedText
    }
}
