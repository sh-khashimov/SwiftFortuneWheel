//
//  CAAnimationGroup+Builder.swift
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


extension CAAnimationGroup {
    
    convenience init(animations : [CAAnimation], fillMode : String!, forEffectLayer : Bool = false, sublayersCount : NSInteger = 0) {
        self.init()
        self.animations = animations
        
        if (fillMode != nil){
            if let animations = self.animations {
                for anim in animations {
                    anim.fillMode = CAMediaTimingFillMode(rawValue: fillMode!)
                }
            }
            self.fillMode = CAMediaTimingFillMode(rawValue: fillMode!)
            self.isRemovedOnCompletion = false
        }

        if forEffectLayer {
            self.duration = self.maxDuration(sublayersCount: sublayersCount)
        }else{
            self.duration = animations.maxDuration
        }
    }
}
