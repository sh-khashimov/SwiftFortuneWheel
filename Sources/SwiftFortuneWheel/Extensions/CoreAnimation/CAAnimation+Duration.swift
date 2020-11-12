//
//  CAAnimation+Duration.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 9/25/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

extension CAAnimation {
    func maxDuration(sublayersCount: NSInteger) -> CFTimeInterval {
        var maxDuration: CGFloat = 0
        if let groupAnim = self as? CAAnimationGroup {
            for subAnim in groupAnim.animations! as [CAAnimation] {
                
                var delay: CGFloat = 0
                if let instDelay = (subAnim.value(forKey: "instanceDelay") as? NSNumber)?.floatValue {
                    delay = CGFloat(instDelay) * CGFloat(sublayersCount - 1)
                }
                var repeatCountDuration: CGFloat = 0
                if subAnim.repeatCount > 1 {
                    repeatCountDuration = CGFloat(subAnim.duration) * CGFloat(subAnim.repeatCount-1)
                }
                var duration: CGFloat = 0
                
                duration = CGFloat(subAnim.beginTime) + (subAnim.autoreverses ? CGFloat(subAnim.duration) : CGFloat(0)) + delay + CGFloat(subAnim.duration) + CGFloat(repeatCountDuration)
                maxDuration = max(duration, maxDuration)
            }
        }
        
        if maxDuration.isInfinite {
            maxDuration = 1000
        }
        
        return CFTimeInterval(maxDuration)
    }
}


extension Sequence where Element == CAAnimation {
    var maxDuration: CFTimeInterval {
        var maxDuration: CGFloat = 0
        for anim in self {
            maxDuration = Swift.max(CGFloat(anim.beginTime + anim.duration) * CGFloat(anim.repeatCount == 0 ? 1.0 : anim.repeatCount) * (anim.autoreverses ? 2.0 : 1.0), maxDuration)
        }
        
        if maxDuration.isInfinite {
            return TimeInterval(NSIntegerMax)
        }
        
        return CFTimeInterval(maxDuration)
    }
}
