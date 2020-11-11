//
//  RotationProgress.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 10/17/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Detects collisions
class CollisionDetector {
    
    /// Layer that animates
    weak var animationObjectLayer: CALayer?
    
    /// On collision callback
    var onCollision: ((_ progress: Double?) -> Void)?
    
    /// Time updater
    private var updater: CADisplayLink?
    
    /// Collision calculator
    private lazy var collisionCalculator = CollisionCalculator()
    
    /// Continuous collision calculator
    private lazy var continuousCollisionCalculator = ContinuousCollisionCalculator()
    
    /// Initializes collisions detector
    /// - Parameters:
    ///   - animationObjectLayer: Layer that animates
    ///   - onCollision: On collision callback
    init(animationObjectLayer: CALayer?, onCollision: ((_ progress: Double?) -> Void)? = nil) {
        self.animationObjectLayer = animationObjectLayer
        self.onCollision = onCollision
        updater = CADisplayLink(target: self, selector: #selector(screenRefresh))
        updater?.add(to: .current, forMode: .default)
        updater?.isPaused = true
    }
    
    /// Prepare collision detection with continuous animation
    /// - Parameters:
    ///   - sliceDegree: Slice degree
    ///   - rotationDegreeOffset: Rotation degree offset
    ///   - fullRotationDegree: Animation full rotation degree
    ///   - speed: Animation speed
    ///   - speedAcceleration: Animation speed acceleration
    func prepareWithContinuousAnimation(sliceDegree: CGFloat, rotationDegreeOffset: CGFloat, fullRotationDegree: CGFloat, speed: CGFloat, speedAcceleration: CGFloat) {
        reset()
        
        continuousCollisionCalculator.calculateCollisionInterval(sliceDegree: sliceDegree, rotationDegreeOffset: rotationDegreeOffset, fullRotationDegree: fullRotationDegree, speed: speed, speedAcceleration: speedAcceleration)
    }
    
    /// Prepare collision detection
    /// - Parameters:
    ///   - sliceDegree: Slice degree
    ///   - rotationDegree: Animation full rotation degree
    ///   - rotationDegreeOffset: Rotation degree offset
    ///   - animationDuration: Animation duration time
    func prepare(sliceDegree: CGFloat, rotationDegree: CGFloat, rotationDegreeOffset: CGFloat, animationDuration: CFTimeInterval) {
        reset()
        
        collisionCalculator.calculateCollisionDegrees(sliceDegree: sliceDegree, rotationDegreeOffset: rotationDegreeOffset, rotationDegree: rotationDegree, animationDuration: animationDuration)
    }
    
    /// Starts
    func start() {
        continuousCollisionCalculator.lastCollisionTime = CACurrentMediaTime()
        updater?.isPaused = false
    }
    
    /// Stops
    func stop() {
        updater?.isPaused = true
    }
    
    /// Reset calculators parametrs
    private func reset() {
        continuousCollisionCalculator.reset()
        collisionCalculator.reset()
    }
    
    /// On screen refresh
    /// - Parameter displaylink: A timer object that allows your application to synchronize its drawing to the refresh rate of the display.
    @objc
    private func screenRefresh(displaylink: CADisplayLink) {
        
        continuousCollisionCalculator.calculateCollisionsIfNeeded(timestamp: displaylink.timestamp, onCollision: { [weak self] progress in
            self?.onCollision?(progress)
        })
        
        let layerRotationZ = animationObjectLayer?.presentation()?.value(forKeyPath: "transform.rotation.z") as? Double
        collisionCalculator.calculateCollisionsIfNeeded(layerRotationZ: layerRotationZ, onCollision: { [weak self] progress in
            self?.onCollision?(progress)
        })
    }
    
}
