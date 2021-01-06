//
//  PinImageCollisionAnimator.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 16/11/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif


#if os(macOS)
// UIDynamics is not Supported in macOS
class PinImageViewCollisionAnimator {
    
    /// Prepares helper class with necessary parameters.
    /// `Prepare` method should be called before using `movePin`
    /// - Parameters:
    ///   - referenceView: Reference view that will serves as the coordinate system
    ///   - pinImageView: Pin Image View
    func prepare(referenceView: UIView, pinImageView: UIView) {
        //
    }
    
    /// Moves pin with animation and physics, simulating the collision effect
    /// - Parameters:
    ///   - force: The force that will affect to collision effect, should be more than 0
    ///   - angle: The angle which will be rotated the Pin Image View
    ///   - position: PinImageView's position
    func movePin(force: Double, angle: CGFloat, position: SFWConfiguration.Position) {
        //
    }
    
    /// Moves pin with animation and physics, simulating the collision effect
    /// - Parameters:
    ///   - collisionEffect: Collision effect object
    ///   - position: PinImageView's position
    func movePinIfNeeded(collisionEffect: CollisionEffect?, position: SFWConfiguration.Position?) {
        //
    }
}
#else
/// Helper class animates pin image with physics
class PinImageViewCollisionAnimator {
    
    /// Physics related animation
    var snapAnimator: UIDynamicAnimator?
    
    /// Snap behavior
    var snapBehavior: UISnapBehavior?
    
    /// Reference view that will serves as the coordinate system
    weak var referenceView: UIView?
    
    /// Pin Image view
    weak var pinImageView: UIView?
    
    /// Prepares helper class with necessary parameters.
    /// `Prepare` method should be called before using `movePin`
    /// - Parameters:
    ///   - referenceView: Reference view that will serves as the coordinate system
    ///   - pinImageView: Pin Image View
    func prepare(referenceView: UIView, pinImageView: UIView) {
        self.pinImageView = pinImageView
        snapAnimator = UIDynamicAnimator(referenceView: referenceView)
        snapBehavior = UISnapBehavior(item: pinImageView, snapTo: pinImageView.center)
        snapAnimator?.addBehavior(snapBehavior!)
    }
    
    /// Moves pin with animation and physics, simulating the collision effect
    /// - Parameters:
    ///   - force: The force that will affect to collision effect, should be more than 0
    ///   - angle: The angle which will be rotated the Pin Image View
    ///   - position: PinImageView's position
    func movePin(force: Double, angle: CGFloat, position: SFWConfiguration.Position) {
        guard let pinImageView = self.pinImageView else { return }
        guard let snapBehavior = self.snapBehavior else { return }
        guard let snapAnimator = self.snapAnimator else { return }
        snapAnimator.removeBehavior(snapBehavior)
        UIView.animate(withDuration: 1 / force) {
            let theta = (angle * -1).torad
            pinImageView.transform = CGAffineTransform(rotationAngle: CGFloat(theta))
        } completion: { (success) in
            snapAnimator.addBehavior(snapBehavior)
        }
    }
    
    /// Moves pin with animation and physics, simulating the collision effect
    /// - Parameters:
    ///   - collisionEffect: Collision effect object
    ///   - position: PinImageView's position
    func movePinIfNeeded(collisionEffect: CollisionEffect?, position: SFWConfiguration.Position?) {
        guard let position = position else { return }
        guard let force = collisionEffect?.force else { return }
        guard let angle = collisionEffect?.angle else { return }
        guard force > 0 else { return }
        movePin(force: force, angle: angle, position: position)
    }
    
}
#endif
