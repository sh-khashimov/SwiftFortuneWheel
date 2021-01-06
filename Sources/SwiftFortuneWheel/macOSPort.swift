//
//  macOSPort.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 7/13/20.
//

import Foundation

#if os(macOS)
import AppKit
typealias UIView = NSView
typealias UIImageView = NSImageView
typealias UIButton = NSButton
typealias UIBezierPath = NSBezierPath
typealias UIScreen = NSScreen
typealias UITapGestureRecognizer = NSClickGestureRecognizer
#endif

#if os(macOS)
import AppKit
public typealias SFWControl = NSControl
public typealias SFWColor = NSColor
public typealias SFWImage = NSImage
public typealias SFWFont = NSFont
public typealias SFWEdgeInsets = NSEdgeInsets
#else
import UIKit
public typealias SFWControl = UIControl
public typealias SFWColor = UIColor
public typealias SFWImage = UIImage
public typealias SFWFont = UIFont
public typealias SFWEdgeInsets = UIEdgeInsets
#endif

#if os(macOS)
extension NSScreen {
    var scale: CGFloat {
        return backingScaleFactor
    }
}
#endif

#if os(macOS)
func UIGraphicsGetCurrentContext() -> CGContext? {
    return NSGraphicsContext.current?.cgContext
}

func UIGraphicsPushContext(_ content: CGContext) {
    NSGraphicsContext.saveGraphicsState()
    let nscg = NSGraphicsContext.init(cgContext: content, flipped: true)
    NSGraphicsContext.current = nscg
}

func UIGraphicsPopContext() {
    NSGraphicsContext.restoreGraphicsState()
}
#endif

#if os(macOS)
extension NSFont {
    var lineHeight: CGFloat {
        var lineHeight:CGFloat = 0
        
        lineHeight += self.ascender
        lineHeight += self.descender
        lineHeight += self.leading
        
        return lineHeight
    }
}
#endif

#if os(macOS)
extension NSView {
    var backgroundColor: NSColor? {
        get {
            guard let color = self.layer?.backgroundColor else { return nil }
            return NSColor(cgColor: color)
        }
        set {
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
    
    func layoutIfNeeded() {
        self.layout()
    }
}
#endif

#if os(macOS)
extension NSImage {
    func tint(color: NSColor) -> NSImage {
        let image = self.copy() as! NSImage
        image.lockFocus()
        
        color.set()
        
        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        imageRect.fill(using: .sourceAtop)
        
        image.unlockFocus()
        
        return image
    }
    
    func draw(at position: NSPoint) {
        self.draw(at: position, from: NSRect(x: 0, y: 0, width: self.size.width, height: self.size.height), operation: .copy, fraction: 1)
    }
}
#endif

#if os(macOS)
extension NSImageView {
    var tintColor: NSColor? {
        get {
            return nil
        }
        set {
            guard let tintColor = newValue else { return }
            self.image = self.image?.tint(color: tintColor)
        }
    }
}
#endif

#if os(macOS)
extension NSButton {
    func setImage(_ image: NSImage?) {
        self.image = image
        self.isBordered = false
    }
    
    func setTitle(_ title: String?, attributes: [NSAttributedString.Key:Any]?) {
        guard let title = title else { return }
        let attributed = NSAttributedString(string: title, attributes: attributes)
        self.attributedTitle = attributed
    }
    
    var isUserInteractionEnabled: Bool {
        get {
            return self.isEnabled
        }
        set {
            self.isEnabled = newValue
            (self.cell as? NSButtonCell)?.imageDimsWhenDisabled = newValue
        }
    }
}
#endif

#if os(macOS)
extension CGRect {
    func inset(by margins: NSEdgeInsets) -> CGRect {
        //        return self.insetBy(dx: (margins.left + margins.right) / 2, dy: (margins.top + margins.bottom) / 2)
        return self.insetBy(dx: margins.left, dy: margins.top)
    }
}
#endif

#if os(macOS)
extension NSBezierPath {
    func addArc(withCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        self.appendArc(withCenter: withCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
    }
    
    func addLine(to: CGPoint) {
        self.line(to: to)
    }
}
#endif
