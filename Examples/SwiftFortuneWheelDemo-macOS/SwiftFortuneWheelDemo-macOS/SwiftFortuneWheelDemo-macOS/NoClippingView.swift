//
//  NoClippintView.swift
//  SwiftFortuneWheelDemo-macOS
//
//  Created by Sherzod Khashimov on 7/13/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import AppKit

class NoClippingView: NSView {
    
    public override var wantsDefaultClipping: Bool {
        return false
    }
    
    override var wantsLayer: Bool {
        set {
            
        }
        get {
            return true
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        self.layer?.masksToBounds = false
    }
    
}
