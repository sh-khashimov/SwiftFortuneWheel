//
//  SpinningAnimatable.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation
import UIKit

protocol SpinningAnimatable: CALayer {}

extension SpinningAnimatable {
    func updateLayerValues(forAnimationId identifier: String) {
        if identifier == "rotation"{
            TTUtils.updateValueFromPresentationLayer(forAnimation: self.animation(forKey: "starRotationAnim"), theLayer: self)
        }
    }

    func removeAnimations(forAnimationId identifier: String) {
        if identifier == "rotation" {
            self.removeAnimation(forKey: "starRotationAnim")
        }
    }

    func removeIndefiniteAnimation() {
        self.removeAnimation(forKey: "starRotationIndefiniteAnim")
    }
}
