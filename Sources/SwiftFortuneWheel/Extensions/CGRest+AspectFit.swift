//
//  CGRest+AspectFit.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension CGSize {
    /// Calculates aspect fit size for image
    /// - Parameter sizeImage: Image size
    /// - Returns: Aspect fit size
    func aspectFit(sizeImage:CGSize) -> CGRect {
        
        let imageSize:CGSize  = sizeImage
        
        let hfactor : CGFloat = imageSize.width/self.width
        let vfactor : CGFloat = imageSize.height/self.height
        
        let factor : CGFloat = max(hfactor, vfactor)
        
        // Divide the size by the greater of the vertical or horizontal shrinkage factor
        let newWidth : CGFloat = imageSize.width / factor
        let newHeight : CGFloat = imageSize.height / factor
        
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        if newWidth > newHeight{
            y = (self.height - newHeight)/2
        }
        if newHeight > newWidth{
            x = (self.width - newWidth)/2
        }
        let newRect:CGRect = CGRect(x: x, y: y, width: newWidth, height: newHeight)
        
        return newRect
        
    }
}
