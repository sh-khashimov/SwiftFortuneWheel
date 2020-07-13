//
//  SpinningWheelAnimator.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation
import CoreGraphics

#if os(macOS)
    import AppKit
#else
    import UIKit
#endif

/// Spinning animator protocol
protocol SpinningAnimatorProtocol: class  {
    /// Layer that animates
    var layerToAnimate: SpinningAnimatable? { get }
}


/// Spinning wheel animator
class SpinningWheelAnimator : NSObject, CAAnimationDelegate {
    
    /// Animation object
    weak var animationObject: SpinningAnimatorProtocol!

    internal var completionBlocks = [CAAnimation: (Bool) -> Void]()
    internal var updateLayerValueForCompletedAnimation : Bool = false
    
    /// Current rotation position used to know where is last time rotation stopped
    var currentRotationPosition: CGFloat?
    
    /// Initialize spinning wheel animator
    /// - Parameter animationObject: Animation object
    init(withObjectToAnimate animationObject:SpinningAnimatorProtocol) {
        self.animationObject = animationObject
    }
    
    /// Start indefinite rotation animation
    /// - Parameter rotationTime: Rotation time
    func addIndefiniteRotationAnimation(rotationTime: CFTimeInterval = 5.000) {

        let fillMode : String = CAMediaTimingFillMode.forwards.rawValue
        let starTransformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        starTransformAnim.values   = [0, 7000 * CGFloat.pi/180]
        starTransformAnim.keyTimes = [0, 1]
        starTransformAnim.duration = rotationTime

        let starRotationAnim : CAAnimationGroup = TTUtils.group(animations: [starTransformAnim], fillMode:fillMode)
        starRotationAnim.repeatCount = Float.infinity
        animationObject.layerToAnimate?.add(starRotationAnim, forKey:"starRotationIndefiniteAnim")
    }
    
    /// Start rotation animation
    /// - Parameters:
    ///   - fullRotationsUntilFinish: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - rotationOffset: Rotation offset
    ///   - completionBlock: Completion block
    func addRotationAnimation(fullRotationsUntilFinish: Int, animationDuration: CFTimeInterval, rotationOffset: CGFloat = 0.0, completionBlock: ((_ finished: Bool) -> Void)? = nil){
        if completionBlock != nil {
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = animationDuration
            completionAnim.delegate = self
            completionAnim.setValue("rotation", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            let layer = animationObject.layerToAnimate
            layer?.add(completionAnim, forKey:"rotation")
            if let anim = layer?.animation(forKey: "rotation") {
                completionBlocks[anim] = completionBlock
            }
        }

        let fillMode : String = CAMediaTimingFillMode.forwards.rawValue
        
        currentRotationPosition = rotationOffset

        let rotation:CGFloat = CGFloat(fullRotationsUntilFinish) * 360.0 + rotationOffset

        ////Star animation
        let starTransformAnim            = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        starTransformAnim.values         = [0, rotation * CGFloat.pi/180]
        starTransformAnim.keyTimes       = [0, 1]
        starTransformAnim.duration       = animationDuration
        starTransformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.0256, 0.874, 0.675, 1)

        let starRotationAnim : CAAnimationGroup = TTUtils.group(animations: [starTransformAnim], fillMode:fillMode)
        animationObject.layerToAnimate?.add(starRotationAnim, forKey:"starRotationAnim")
    }

    //MARK: - Animation Cleanup
    
    /// Animation did stop
    /// - Parameters:
    ///   - anim: animation
    ///   - flag: flag
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValue(forKey: anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.value(forKey: "needEndAnim") as! Bool{
                animationObject.layerToAnimate?.updateLayerValues(forAnimationId: anim.value(forKey: "animId") as! String)
                animationObject.layerToAnimate?.removeAnimations(forAnimationId: anim.value(forKey: "animId") as! String)
            }
            completionBlock(flag)
        }
    }

}
