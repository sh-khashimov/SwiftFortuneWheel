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

class CollisionDetector {
    
    weak var animationObjectLayer: CALayer?
    
    var onCollision: (() -> Void)?
    
    private var updater: CADisplayLink?
    
    private var lastSecond: CFTimeInterval = 0
    
    private var lastPlayedInSecond: Double = 0
    
    private var tickDegrees: [Double] = []
    
    private var rotationCount: Int = 0
    
    private var totalRotationDegree: Double = 0
    
    private var lastRotationDegree: Double?
    
    private var tickInterval: CFTimeInterval?
    
    private var currentTick: Int = 0
    
    private var timer: Timer?
    
    init(animationObjectLayer: CALayer?, onCollision: (() -> Void)? = nil) {
        self.animationObjectLayer = animationObjectLayer
        self.onCollision = onCollision
        updater = CADisplayLink(target: self, selector: #selector(rotationChange))
        updater?.add(to: .current, forMode: .default)
        updater?.isPaused = true
    }
    
    func prepareIndefiniteRotation(sliceDegree: CGFloat, rotationDegreeOffset: CGFloat, fullRotationDegree: CGFloat, speed: CGFloat, speedAcceleration: CGFloat) {
        reset()
        tickInterval = CFTimeInterval(sliceDegree / (fullRotationDegree * speed * speedAcceleration))
    }
    
    func prepareRotation(sliceDegree: CGFloat, rotationDegree: CGFloat, rotationDegreeOffset: CGFloat, animationDuration: CFTimeInterval) {
        reset()
        calculateTickDegree(sliceDegree: sliceDegree, rotationDegreeOffset: rotationDegreeOffset, rotationDegree: rotationDegree, animationDuration: animationDuration)
    }
    
    func start() {
        
        lastSecond = CACurrentMediaTime()
        lastPlayedInSecond = Date().timeIntervalSince1970
        
        updater?.isPaused = false
        
//        timer?.fire()
    }
    
    func stop() {
        updater?.isPaused = true
        
//        timer?.invalidate()
//        timer = nil
    }
    
    private func reset() {
        tickInterval = nil
        tickDegrees = []
        currentTick = 0
        rotationCount = 0
        totalRotationDegree = 0
        lastRotationDegree = nil
    }
    
    private func calculateTickDegree(sliceDegree: CGFloat, rotationDegreeOffset: CGFloat, rotationDegree: CGFloat, animationDuration: CFTimeInterval) {
        let sectorsCount = (rotationDegree / sliceDegree)
        
        for index in 0..<Int(sectorsCount) {
            let degree = ((sliceDegree / 2) + (CGFloat(index) * sliceDegree))
            tickDegrees.append(Double(degree))
        }
        
//        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    @objc
    private func tick() {
        
        calculateRotationChangeIfNeeded()
    }
    
    @objc
    private func rotationChange(displaylink: CADisplayLink) {
        
        calculateIndifinateRotationChangeIfNeeded(displaylink: displaylink)
        
        calculateRotationChangeIfNeeded()
    }
    
    private func calculateIndifinateRotationChangeIfNeeded(displaylink: CADisplayLink) {
        let timestamp = displaylink.timestamp
        if let tickInterval = self.tickInterval {
            let interval = currentTick == 0 ? tickInterval / 2 : tickInterval
            if lastSecond + interval < timestamp {
                lastSecond = timestamp
                currentTick += 1
                onCollision?()
            }
        }
    }
    
    private func calculateRotationChangeIfNeeded() {
        if tickDegrees.count > 0,
           let rotationZ = animationObjectLayer?.presentation()?.value(forKeyPath: "transform.rotation.z") as? Double {
            guard currentTick < tickDegrees.count else { return }
            
            print("rotationZ: \(rotationZ)")
            
            let rotationOffset = rotationZ * 180.0 / .pi
            
            let currentRotationDegree = rotationOffset >= 0 ? rotationOffset : 360 + rotationOffset
            
            totalRotationDegree = Double(rotationCount * 360) + currentRotationDegree
            
            let currentTickDegree = tickDegrees[currentTick]
            
            if currentTickDegree < totalRotationDegree {
                var nextTick = currentTick + 1
                guard currentTick < tickDegrees.count else {
                    currentTick = nextTick
                    onCollision?()
                    return
                }
                let nextTickDegrees = tickDegrees[currentTick+1..<tickDegrees.count]
                for nextTickDegree in nextTickDegrees {
                    if nextTickDegree < totalRotationDegree {
                        nextTick += 1
                    } else {
                        break
                    }
                }
                currentTick = nextTick
                onCollision?()
            }

            if lastRotationDegree ?? 0 > currentRotationDegree {
                rotationCount += 1
            }
            
            lastRotationDegree = currentRotationDegree
        }
    }
    
}
