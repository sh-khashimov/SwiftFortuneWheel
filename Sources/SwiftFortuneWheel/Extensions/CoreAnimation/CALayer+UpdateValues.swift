//
//  CALayer+UpdateValues.swift
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

extension CALayer {
    func updateValue(forAnimation anim: CAAnimation) {
        if let basicAnim = anim as? CABasicAnimation {
            if (!basicAnim.autoreverses) {
                self.setValue(basicAnim.toValue, forKeyPath: basicAnim.keyPath!)
            }
        } else if let keyAnim = anim as? CAKeyframeAnimation {
            if (!keyAnim.autoreverses) {
                self.setValue(keyAnim.values?.last, forKeyPath: keyAnim.keyPath!)
            }
        } else if let groupAnim = anim as? CAAnimationGroup {
            for subAnim in groupAnim.animations! as [CAAnimation] {
                updateValue(forAnimation: subAnim)
                
            }
        }
    }
    
    func updateValueFromPresentationLayer(forAnimation anim: CAAnimation!) {
        if let basicAnim = anim as? CABasicAnimation {
            self.setValue(self.presentation()?.value(forKeyPath: basicAnim.keyPath!), forKeyPath: basicAnim.keyPath!)
        } else if let keyAnim = anim as? CAKeyframeAnimation {
            self.setValue(self.presentation()?.value(forKeyPath: keyAnim.keyPath!), forKeyPath: keyAnim.keyPath!)
        } else if let groupAnim = anim as? CAAnimationGroup {
            for subAnim in groupAnim.animations! as [CAAnimation] {
                updateValueFromPresentationLayer(forAnimation: subAnim)
            }
        }
    }
}

extension Sequence where Element == CALayer {
    func updateValueFromAnimations() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        for aLayer in self {
            if let keys = aLayer.animationKeys() as [String]?{
                for animKey in keys{
                    let anim = aLayer.animation(forKey: animKey)
                    aLayer.updateValue(forAnimation: anim!)
                }
            }
            
        }
        
        CATransaction.commit()
    }
}
