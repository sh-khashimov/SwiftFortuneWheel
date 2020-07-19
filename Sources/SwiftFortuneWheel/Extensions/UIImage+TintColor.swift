//
//  File.swift
//  
//
//  Created by Sherzod Khashimov on 6/7/20.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension SFWImage {
    /// Tint the image with color
    /// - Parameter color: Color
    /// - Returns: Tinted image
    func withTintColor(_ tintColor: SFWColor) -> SFWImage {
        var image: SFWImage = self
        
        #if os(tvOS)
        if #available(tvOSApplicationExtension 13.0, *) {
            image = self.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        } else {
            // Fallback on earlier versions
            image = self.withColor(tintColor)
        }
        #elseif os(macOS)
        image = self.withColor(tintColor)
        #else
        if #available(iOS 13.0, *) {
            image = self.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        } else {
            // Fallback on earlier versions
            image = self.withColor(tintColor)
        }
        #endif
        
        return image
    }
    
    private func withColor(_ color: SFWColor) -> SFWImage {
        #if os(macOS)
        return self.tint(color: color)
        #else
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }
        color.setFill()
        ctx.translateBy(x: 0, y: size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.clip(to: CGRect(x: 0, y: 0, width: size.width, height: size.height), mask: cgImage)
        ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        return colored
        #endif
    }
}
