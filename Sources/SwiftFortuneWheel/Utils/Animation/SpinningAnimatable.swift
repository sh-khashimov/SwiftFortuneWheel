//
//  SpinningAnimatable.swift
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

/// Spinning animatable protocol
protocol SpinningAnimatable: CALayer {}

extension SpinningAnimatable {
    /// Updates layer values
    /// - Parameter identifier: animation identifier
    func updateLayerValues(forAnimationId identifier: String) {
        if identifier == "rotation"{
            self.updateValueFromPresentationLayer(forAnimation: self.animation(forKey: "starRotationAnim"))
        }
    }
    
    /// Removes animations
    /// - Parameter identifier: animation identifier
    func removeAnimations(forAnimationId identifier: String) {
        if identifier == "rotation" {
            self.removeAnimation(forKey: "starRotationAnim")
        }
    }
    
    /// Removes indefinite animation
    func removeIndefiniteAnimation() {
        self.removeAnimation(forKey: "starRotationIndefiniteAnim")
    }
}
