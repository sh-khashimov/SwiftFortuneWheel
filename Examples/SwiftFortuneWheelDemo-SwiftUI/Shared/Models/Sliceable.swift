//
//  Sliceable.swift
//  SwiftFortuneWheelDemoSwiftUI
//
//  Created by Sherzod Khashimov on 07/01/22.
//

import Foundation
import SwiftFortuneWheel

protocol Sliceable {
    /// Contents in vertical align order
    var contents: [Slice.ContentType] { get set }
    
    /// Background color, `optional`
    var backgroundColor: SFWColor? { get set }
    
    /// Background image, `optional`
    var backgroundImage: SFWImage? { get set }
    
    /// Background gradient color, `optional`
    var gradientColor: SFGradientColor? { get set }
}

extension Slice: Sliceable {}
