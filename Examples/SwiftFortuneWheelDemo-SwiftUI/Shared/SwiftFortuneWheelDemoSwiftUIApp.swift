//
//  SwiftFortuneWheelDemoSwiftUIApp.swift
//  Shared
//
//  Created by Sherzod Khashimov on 07/01/22.
//

import SwiftUI

@main
struct SwiftFortuneWheelDemoSwiftUIApp: App {
    
    init() {
        UIScrollView.appearance().keyboardDismissMode = .onDrag
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
