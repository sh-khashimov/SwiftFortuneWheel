//
//  NoClippingLayer.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 7/13/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

class NoClippingLayer: CALayer {
    override var masksToBounds: Bool {
        set {
            
        }
        get {
            return false
        }
    }
}
