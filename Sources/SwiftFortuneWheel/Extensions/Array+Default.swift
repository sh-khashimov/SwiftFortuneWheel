//
//  Array+Default.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/6/20.
// 
//

import Foundation

extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        
        return self[index]
    }
}
