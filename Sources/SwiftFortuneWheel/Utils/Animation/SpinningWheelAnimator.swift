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
protocol SpinningAnimatorProtocol: class, CollisionProtocol  {
    /// Layer that animates
    var layerToAnimate: SpinningAnimatable? { get }
}


/// Spinning wheel animator
class SpinningWheelAnimator: NSObject {
    
    /// Animation object
    weak var animationObject: SpinningAnimatorProtocol?
    
    /// Edge Collision Detector
    lazy var edgeCollisionDetector: CollisionDetector = CollisionDetector(animationObjectLayer: animationObject?.layerToAnimate)
    
    /// Center Collision Detector
    lazy var centerCollisionDetector: CollisionDetector = CollisionDetector(animationObjectLayer: animationObject?.layerToAnimate)
    
    /// Animation Completion Block
    var completionBlock: ((Bool) -> Void)?
    
    /// Current rotation position used to know where is last time rotation stopped
    var currentRotationPosition: CGFloat?
    
    /// Rotation direction offset
    var rotationDirectionOffset: CGFloat {
        #if os(macOS)
        return -1
        #else
        return 1
        #endif
    }
    
    /// Is object layer is currently rotation
    var isRotating: Bool {
        return startedAnimationCount > 0
    }
    
    /// Counts started animations
    private var startedAnimationCount: Int = 0
    
    /// Initialize spinning wheel animator
    /// - Parameter animationObject: Animation object
    init(withObjectToAnimate animationObject: SpinningAnimatorProtocol) {
        super.init()
        self.animationObject = animationObject
    }
    
    /// Start indefinite rotation animation
    /// - Parameter speed: Rotation speed, speed is equal to full rotation quantity in one second
    func addIndefiniteRotationAnimation(speed: CGFloat = 1,
                                        onEdgeCollision: ((_ progress: Double?) -> Void)? = nil,
                                        onCenterCollision: ((_ progress: Double?) -> Void)? = nil) {
        
        let fullRotationDegree: CGFloat = 360
        let speedAcceleration: CGFloat = 1
        
        prepareAllCollisionDetectorsIfNeeded(with: fullRotationDegree,
                                             speed: speed,
                                             speedAcceleration: speedAcceleration,
                                             onEdgeCollision: onEdgeCollision,
                                             onCenterCollision: onCenterCollision)
        
        let fillMode : String = CAMediaTimingFillMode.forwards.rawValue
        let transformAnim      = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        transformAnim.values   = [0, fullRotationDegree * speed * speedAcceleration * CGFloat.pi/180 * rotationDirectionOffset]
        transformAnim.keyTimes = [0, 1]
        transformAnim.duration = 1
        
        let rotationAnim : CAAnimationGroup = CAAnimationGroup(animations: [transformAnim], fillMode:fillMode)
        rotationAnim.repeatCount = Float.infinity
        rotationAnim.delegate = self
        animationObject?.layerToAnimate?.add(rotationAnim, forKey:"starRotationIndefiniteAnim")
        
        startedAnimationCount += 1
        startCollisionDetectorsIfNeeded()
        
    }
    
    /// Start rotation animation
    /// - Parameters:
    ///   - fullRotationsCount: Full rotations until start deceleration
    ///   - animationDuration: Animation duration
    ///   - rotationOffset: Rotation offset
    ///   - completionBlock: Completion block
    func addRotationAnimation(fullRotationsCount: Int,
                              animationDuration: CFTimeInterval,
                              rotationOffset: CGFloat = 0.0,
                              completionBlock: ((_ finished: Bool) -> Void)? = nil,
                              onEdgeCollision: ((_ progress: Double?) -> Void)? = nil,
                              onCenterCollision: ((_ progress: Double?) -> Void)? = nil) {
        
        self.currentRotationPosition = rotationOffset
        
        let rotation: CGFloat = CGFloat(fullRotationsCount) * 360.0 + rotationOffset
        
        prepareAllCollisionDetectorsIfNeeded(with: rotation,
                                             animationDuration: animationDuration,
                                             onEdgeCollision: onEdgeCollision,
                                             onCenterCollision: onCenterCollision)
        
        ////Start animation
        let transformAnim            = CAKeyframeAnimation(keyPath:"transform.rotation.z")
        transformAnim.values         = [0, rotation * rotationDirectionOffset * CGFloat.pi/180]
        transformAnim.keyTimes       = [0, 1]
        transformAnim.duration       = animationDuration
        transformAnim.timingFunction = CAMediaTimingFunction(controlPoints: 0.0256, 0.874, 0.675, 1)
        transformAnim.fillMode = CAMediaTimingFillMode.forwards
        transformAnim.isRemovedOnCompletion = false
        transformAnim.delegate = self
        if completionBlock != nil {
            transformAnim.setValue("rotation", forKey:"animId")
            self.completionBlock = completionBlock
        }
        
        animationObject?.layerToAnimate?.add(transformAnim, forKey:"starRotationAnim")
        
        // to fix the problem of the layer's presentation becoming nil in detectors
        edgeCollisionDetector.animationObjectLayer = animationObject?.layerToAnimate
        centerCollisionDetector.animationObjectLayer = animationObject?.layerToAnimate
        
        startedAnimationCount += 1
        startCollisionDetectorsIfNeeded()
    }
    
    /// Stops animations and collisions detectors if needed
    func stop() {
        self.animationObject?.layerToAnimate?.removeAllAnimations()
        stopCollisionDetectorsIfNeeded()
    }
    
    func resetRotationPosition() {
        currentRotationPosition = nil
    }
}

// MARK: - CAAnimationDelegate

extension SpinningWheelAnimator: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if let completionBlock = self.completionBlock,
           let animId = anim.value(forKey: "animId") as? String, animId == "rotation" {
            completionBlock(flag)
            self.completionBlock = nil
        }
        startedAnimationCount -= 1
        if startedAnimationCount < 1 {
            stopCollisionDetectorsIfNeeded()
        }
    }
}

// MARK: - Collision Detection Support

extension SpinningWheelAnimator: CollisionDetectable {}
