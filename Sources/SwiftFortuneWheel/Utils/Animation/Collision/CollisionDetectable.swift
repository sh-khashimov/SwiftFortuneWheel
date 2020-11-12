//
//  CollisionDelecting.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 10/29/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Collision Protocol
protocol CollisionProtocol {
    /// Slice Degree
    var sliceDegree: CGFloat? { get }
    
    /// Edge collision detection is active or not
    var edgeCollisionDetectionOn: Bool { get }
    
    /// Center collision detection is active or not
    var centerCollisionDetectionOn: Bool { get }
    
    /// Ednge anchor rotation offset
    var edgeAnchorRotationOffset: CGFloat { get }
    
    /// Center anchor rotation offset
    var centerAnchorRotationOffset: CGFloat { get }
}

/// Collision Detection Support protocol
protocol CollisionDetectable: NSObject {
    
    /// Animation object
    var animationObject: SpinningAnimatorProtocol? { get set }
    
    /// Edge Collision Detector
    var edgeCollisionDetector: CollisionDetector { get set }
    
    /// Center Collision Detector
    var centerCollisionDetector: CollisionDetector { get set }
}

extension CollisionDetectable {
    
    /// Starts all collision detectors if needed
    func startCollisionDetectorsIfNeeded() {
        startCollisionDetectorIfNeeded(type: .edge)
        startCollisionDetectorIfNeeded(type: .center)
    }
    
    /// Stops all collision detectos if needed
    func stopCollisionDetectorsIfNeeded() {
        stopCollisionDetectorIfNeeded(type: .edge)
        stopCollisionDetectorIfNeeded(type: .center)
    }
    
    /// Prepares all collision detectors if needed
    /// - Parameters:
    ///   - rotationDegree: Animation full rotation degree
    ///   - animationDuration: Animation duration time
    ///   - onEdgeCollision: On edge collision callback
    ///   - onCenterCollision: On center collision callback
    func prepareAllCollisionDetectorsIfNeeded(with rotationDegree: CGFloat,
                                              animationDuration: CFTimeInterval,
                                              onEdgeCollision: ((_ progress: Double?) -> Void)? = nil,
                                              onCenterCollision: ((_ progress: Double?) -> Void)? = nil) {
        prepareCollisionDetectorIfNeeded(for: .edge,
                                         with: rotationDegree,
                                         animationDuration: animationDuration,
                                         onCollision: onEdgeCollision)
        prepareCollisionDetectorIfNeeded(for: .center,
                                         with: rotationDegree,
                                         animationDuration: animationDuration,
                                         onCollision: onCenterCollision)
    }
    
    /// Prepare collision detector if needed by collision type
    /// - Parameters:
    ///   - type: Collision type
    ///   - rotationDegree: Animation full rotation degree
    ///   - animationDuration: Animation duration time
    ///   - onCollision: On collision callback
    func prepareCollisionDetectorIfNeeded(for type: CollisionType,
                                          with rotationDegree: CGFloat,
                                          animationDuration: CFTimeInterval,
                                          onCollision: ((_ progress: Double?) -> Void)? = nil) {
        
        guard isCollisionDetectorOn(for: type) else { return }
        guard let sliceDegree = self.animationObject?.sliceDegree else { return }
        let rotationOffset = rotationDegreeOffset(for: type)
        
        switch type {
        case .edge:
            edgeCollisionDetector.onCollision = onCollision
            edgeCollisionDetector.prepare(sliceDegree: sliceDegree, rotationDegree: rotationDegree, rotationDegreeOffset: rotationOffset, animationDuration: animationDuration)
        case .center:
            centerCollisionDetector.onCollision = onCollision
            centerCollisionDetector.prepare(sliceDegree: sliceDegree, rotationDegree: rotationDegree, rotationDegreeOffset: rotationOffset, animationDuration: animationDuration)
        }
    }
    
    /// Prepare all collision detectors if needed with continuous animation
    /// - Parameters:
    ///   - rotationDegree: Animation full rotation degree
    ///   - speed: Rotation speed
    ///   - speedAcceleration: Rotation speed acceleration
    ///   - onEdgeCollision: On edge collision callback
    ///   - onCenterCollision: On center collision callback
    func prepareAllCollisionDetectorsIfNeeded(with rotationDegree: CGFloat,
                                              speed: CGFloat,
                                              speedAcceleration: CGFloat,
                                              onEdgeCollision: ((_ progress: Double?) -> Void)? = nil,
                                              onCenterCollision: ((_ progress: Double?) -> Void)? = nil) {
        prepareCollisionDetectorIfNeeded(for: .edge,
                                         with: rotationDegree,
                                         speed: speed,
                                         speedAcceleration: speedAcceleration,
                                         onCollision: onEdgeCollision)
        prepareCollisionDetectorIfNeeded(for: .center,
                                         with: rotationDegree,
                                         speed: speed,
                                         speedAcceleration: speedAcceleration,
                                         onCollision: onCenterCollision)
    }
    
    /// Prepare collision detector if needed with continuous animation by collision type
    /// - Parameters:
    ///   - type: Collision type
    ///   - rotationDegree: Animation full rotation degree
    ///   - speed: Rotation speed
    ///   - speedAcceleration: Rotation speed acceleration
    ///   - onCollision: On collision callback
    func prepareCollisionDetectorIfNeeded(for type: CollisionType,
                                          with rotationDegree: CGFloat,
                                          speed: CGFloat,
                                          speedAcceleration: CGFloat,
                                          onCollision: ((_ progress: Double?) -> Void)? = nil) {
        
        guard isCollisionDetectorOn(for: type) else { return }
        guard let sliceDegree = self.animationObject?.sliceDegree else { return }
        let rotationOffset = rotationDegreeOffset(for: type)
        
        switch type {
        case .edge:
            edgeCollisionDetector.onCollision = onCollision
            edgeCollisionDetector.prepareWithContinuousAnimation(sliceDegree: sliceDegree, rotationDegreeOffset: rotationOffset,
                                                fullRotationDegree: rotationDegree,
                                                speed: speed,
                                                speedAcceleration: speedAcceleration)
        case .center:
            centerCollisionDetector.onCollision = onCollision
            centerCollisionDetector.prepareWithContinuousAnimation(sliceDegree: sliceDegree, rotationDegreeOffset: rotationOffset,
                                                fullRotationDegree: rotationDegree,
                                                speed: speed,
                                                speedAcceleration: speedAcceleration)
        }
    }
    
    /// Returns rotation degree offset to collision type
    /// - Parameter type: Collision type
    /// - Returns: Rotation degree offset
    func rotationDegreeOffset(for type: CollisionType) -> CGFloat {
        let sliceDegree = self.animationObject?.sliceDegree ?? 0
        switch type {
        case .edge:
            return (sliceDegree / 2) + (animationObject?.edgeAnchorRotationOffset ?? 0)
        case .center:
            return animationObject?.centerAnchorRotationOffset ?? 0
        }
    }
    
    /// Starts collision detector if needed by collision type
    /// - Parameter type: Collision type
    func startCollisionDetectorIfNeeded(type: CollisionType) {
        guard isCollisionDetectorOn(for: type) else { return }
        
        switch type {
        case .edge:
            edgeCollisionDetector.start()
        case .center:
            centerCollisionDetector.start()
        }
    }
    
    /// Stops collision detector if needed by collision type
    /// - Parameter type: Collision type
    func stopCollisionDetectorIfNeeded(type: CollisionType) {
        guard isCollisionDetectorOn(for: type) else { return }
        
        switch type {
        case .edge:
            edgeCollisionDetector.stop()
        case .center:
            centerCollisionDetector.stop()
        }
    }
    
    /// Checks are collision detector is on for collision type
    /// - Parameter type: Collision type
    /// - Returns: Is collision detection on or off
    func isCollisionDetectorOn(for type: CollisionType) -> Bool {
        switch type {
        case .edge:
            return animationObject?.edgeCollisionDetectionOn ?? false
        case .center:
            return animationObject?.centerCollisionDetectionOn ?? false
        }
    }
}
