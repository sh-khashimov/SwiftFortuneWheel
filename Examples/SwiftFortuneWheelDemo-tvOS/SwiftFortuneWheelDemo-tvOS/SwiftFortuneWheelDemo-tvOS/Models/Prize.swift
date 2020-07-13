//
//  Prize.swift
//  SwiftFortuneWheelDemo-tvOS
//
//  Created by Sherzod Khashimov on 7/12/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import Foundation

struct Prize {
    var amount: Int
    var description: String
    var priceType: PriceType
}

extension Prize {
    enum PriceType {
        case money
        case points
        case exp

        var imageName: String {
            switch self {
            case .money:
                return "trophy-cup"
            case .points:
                return "trophy-cup"
            case .exp:
                return "crown"
            }
        }
    }

}

extension Prize {
    var amountFormatted: String {
        return "\(amount)"
    }
}
