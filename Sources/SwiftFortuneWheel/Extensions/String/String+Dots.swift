//
//  String+Dots.swift
//  SwiftFortuneWheel-iOS
//
//  Created by Sherzod Khashimov on 6/26/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

extension String {
    /// Replaces characters with dots at the end
    /// - Parameter count: last character count
    mutating func replaceLastCharactersWithDots(count: Int = 3) {
        var string = self
        let dots = Array.init(repeating: ".", count: count).joined()
        let start = string.index(string.endIndex, offsetBy: -count)
        let end = string.endIndex
        string.replaceSubrange(start..<end, with: dots)
        self = string
    }
}
