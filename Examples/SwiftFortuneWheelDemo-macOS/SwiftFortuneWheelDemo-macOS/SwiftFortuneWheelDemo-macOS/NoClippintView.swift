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
    
}
