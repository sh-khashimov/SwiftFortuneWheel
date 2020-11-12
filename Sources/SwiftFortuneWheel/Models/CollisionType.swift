//
//  CollisionType.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 10/28/20.
//  Copyright © 2020 SwiftFortuneWheel. All rights reserved.
//

import Foundation

/// Collision Type
enum CollisionType {
    case edge, center
    
    /// Identifier
    var identifier: String {
        switch self {
        case .edge:
            return "edgeCollision"
        case .center:
            return "centerCollision"
        }
    }
}
