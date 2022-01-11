//
//  HideKeyboard.swift
//  SwiftFortuneWheelDemoSwiftUI
//
//  Created by Sherzod Khashimov on 08/01/22.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
