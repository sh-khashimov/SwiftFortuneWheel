//
//  UIFont.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/5/20.
// 
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension SFWFont {
    /// Calculates size of string
    /// - Parameters:
    ///   - string: string
    ///   - width: maximum width
    /// - Returns: return size of string
    func sizeOfString(string: String, constrainedToWidth width: CGFloat) -> CGSize {
        #if os(macOS)
        let options = NSString.DrawingOptions.usesFontLeading
        #else
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        #endif
        return NSString(string: string).boundingRect(
            with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
            options: options,
            attributes: [NSAttributedString.Key.font: self],
            context: nil
        ).size
    }
    
    /// Number of characters that fit witdh
    /// - Parameters:
    ///   - text: text
    ///   - width: maximum width
    ///   - numberOfLines: number of lines
    /// - Returns: number of characters
    func number(ofCharacters text: String, thatFit width: CGFloat, numberOfLines: Int = 1) -> Int {
        let fontRef = CTFontCreateWithName(self.fontName as CFString, self.pointSize, nil)
        let attributes = [kCTFontAttributeName : fontRef]
        let attributedString = NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
        let frameSetterRef = CTFramesetterCreateWithAttributedString(attributedString as CFAttributedString)
        
        var characterFitRange: CFRange = CFRange()
        
        CTFramesetterSuggestFrameSizeWithConstraints(frameSetterRef, CFRangeMake(0, 0), nil, CGSize(width: width, height: CGFloat(numberOfLines)*self.lineHeight), &characterFitRange)
        return Int(characterFitRange.length)
    }
}
