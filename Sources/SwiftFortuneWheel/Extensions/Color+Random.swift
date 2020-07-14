//
//  Color+Random.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/4/20.
// 
//

import Foundation

#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension SFWColor {
    /// Random color
    static var random: SFWColor {
        return SFWColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
