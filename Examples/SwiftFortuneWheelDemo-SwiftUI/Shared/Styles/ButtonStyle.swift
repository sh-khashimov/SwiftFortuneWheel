//
//  ButtonStyle.swift
//  SwiftFortuneWheelDemoSwiftUI
//
//  Created by Sherzod Khashimov on 08/01/22.
//

import Foundation
import SwiftUI

struct CyanButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(.cyan)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
