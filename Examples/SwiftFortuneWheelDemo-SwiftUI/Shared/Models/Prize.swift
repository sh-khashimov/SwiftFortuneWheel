//
//  Prize.swift
//  SwiftFortuneWheelDemoSwiftUI
//
//  Created by Sherzod Khashimov on 08/01/22.
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
