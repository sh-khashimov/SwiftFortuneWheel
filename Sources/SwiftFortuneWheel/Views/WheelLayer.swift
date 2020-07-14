//
//  WheelLayer.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 5/28/20.
// 
//

import CoreGraphics

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Wheel layer
class WheelLayer: CALayer {
    
    /// Customizable preferences.
    /// Required in order to draw properly.
    var preferences: SFWConfiguration.WheelPreferences?
    
    /// List of Slice objects.
    /// Used to draw content.
    var slices:[Slice] = []
    
    /// Main frame with inserts.
    var mainFrame: CGRect!
    
    /// Initiates without IB.
    /// - Parameters:
    ///   - frame: Frame
    ///   - slices: List of Slices
    ///   - configuration: Customizable configuration
    init(frame:CGRect, slices: [Slice], preferences: SFWConfiguration.WheelPreferences?) {
        self.slices = slices
        self.preferences = preferences
        super.init()
        self.frame = frame
        self.backgroundColor = SFWColor.clear.cgColor
        #if os(macOS)
        self.contentsScale = UIScreen.main?.scale ?? 1
        self.isGeometryFlipped = true
        #else
        self.contentsScale = UIScreen.main.scale
        #endif
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        updateSizes()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateSizes()
    }
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        UIGraphicsPushContext(ctx)
        drawCanvas(with: mainFrame)
        UIGraphicsPopContext()
    }
    
    override var masksToBounds: Bool {
        set {
            
        }
        get {
            return false
        }
    }
    
    /// Draws the wheel with slices in canvas
    /// - Parameter frame: Draws with frame
    func drawCanvas(with frame: CGRect) {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Main Group
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        //// Slice drawings
        let startPositionOffsetDegree = preferences?.startPosition.startAngleOffset ?? 0
        let offSetDegree: CGFloat = (sliceDegree / 2)
        var rotation:CGFloat = -sliceDegree + startPositionOffsetDegree
        let start:CGFloat = -offSetDegree
        let end = sliceDegree - offSetDegree
        
        // Draws slices with content
        self.slices.enumerated().forEach { (index,element) in
            rotation += sliceDegree
            self.drawSlice(withIndex: index,
                           in: context,
                           forSlice: element,
                           rotation:rotation,
                           start: start,
                           end: end)
        }
        
        //// Frame drawing
        let circleFrame = UIBezierPath(ovalIn: frame)
        preferences?.circlePreferences.strokeColor.setStroke()
        circleFrame.lineWidth = preferences?.circlePreferences.strokeWidth ?? 0
        circleFrame.stroke()
        
        // Optional, draws image anchor for each slice, located at the wheel's border
        if let imageAnchor = preferences?.imageAnchor {
            var _rotation: CGFloat = -sliceDegree + startPositionOffsetDegree
            for index in 0..<slices.count {
                _rotation += sliceDegree
                self.drawAnchorImage(in: context,
                                     imageAnchor: imageAnchor,
                                     isCentered: false,
                                     rotation: _rotation,
                                     index: index,
                                     radius: radius,
                                     sliceDegree: sliceDegree,
                                     rotationOffset: rotationOffset)
            }
        }
        
        // Optional, draws image anchor for each slice, located at the center of wheel's border
        if let imageAnchor = preferences?.centerImageAnchor {
            var _rotation: CGFloat = -sliceDegree + startPositionOffsetDegree
            for index in 0..<slices.count {
                _rotation += sliceDegree
                self.drawAnchorImage(in: context,
                                     imageAnchor: imageAnchor,
                                     isCentered: true,
                                     rotation: _rotation,
                                     index: index,
                                     radius: radius,
                                     sliceDegree: sliceDegree,
                                     rotationOffset: rotationOffset)
            }
        }
        
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
}

extension WheelLayer: SliceDrawing {}
extension WheelLayer: SpinningAnimatable {}
