//
//  UIView+CornerRadius.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/8/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation
import AppKit

extension NSView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer?.cornerRadius ?? 0
        }
        set {
            self.layer?.cornerRadius = newValue
        }
    }
}
