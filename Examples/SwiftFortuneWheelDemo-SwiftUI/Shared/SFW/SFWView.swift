//
//  SFWView.swift
//  SwiftFortuneWheelDemoSwiftUI
//
//  Created by Sherzod Khashimov on 07/01/22.
//

import UIKit
import SwiftUI
import Combine
import SwiftFortuneWheel

/// SwiftUI View wrapper for SwiftFortuneWheel
struct SFWView: UIViewRepresentable {
    
    /// Array of prizes that will be mapped to slides for SwiftFortuneWheel
    @Binding var prizes: [Prize]
    /// Configurator for SwiftFortuneWheel, customizes appearance
    @Binding var configuration: SFWConfiguration
    
    /// Responsible for whether the text should be the black color everywhere or not
    @Binding var isMonochrome: Bool
    /// Should draw a line or not
    @Binding var isWithLine: Bool
    
    /// Callback on clicking the spin button
    @Binding var onSpinButtonTap: (() -> Void)?
    
    /// Rotate to specified index
    let rotateToIndex: AnyPublisher<Int, Never>
    /// SwiftFortuneWheel redraw signal
    let shouldRedraw: AnyPublisher<Bool, Never>
    
    /// All cancellable subscribes
    @State private var subscribes = Set<AnyCancellable>()
    
    /// SwiftFortuneWheel instance
    private let sfwControl = SwiftFortuneWheel(frame: CGRect(), slices: [], configuration: nil)
    
    func makeUIView(context: Context) -> SwiftFortuneWheel {
        sfwControl.isSpinEnabled = true
        sfwControl.spinTitle = "SPIN"
        sfwControl.pinImage = "long-arrow-up"
        sfwControl.onSpinButtonTap = {
            self.onSpinButtonTap?()
        }
        
        DispatchQueue.main.async {
            rotateToIndex.sink(receiveValue: { (finishedIndex) in
                self.rotate(to: finishedIndex)
            }).store(in: &subscribes)
        }
        
        DispatchQueue.main.async {
            shouldRedraw.sink(receiveValue: { shouldRedraw in
                guard shouldRedraw else { return }
                sfwControl.slices = prizes.slices(isMonotone: isMonochrome, isWithLine: isWithLine)
                sfwControl.configuration = configuration
            }).store(in: &subscribes)
        }
        
        
        return sfwControl
    }
    
    func updateUIView(_ uiView: SwiftFortuneWheel, context: Context) {
        ///SwiftUI is managing the memory of @State and @Binding objects and automatically refreshes any UI of any Views that rely on your variable.
        ///Unfortunately, any update of @State and @Binding parameters on the parent view will call this method.
        ///This means that if the wheel is spinning, updating any parameter on the parent view, even if this parameter is not used in SFWView, will stop the animation.
        ///To solve this problem, send a signal to `shouldRedraw` if you need  redraw the SwiftFortuneWheel.
        guard uiView.slices.count == 0, uiView.configuration == nil else { return }
        
        uiView.slices = prizes.slices(isMonotone: isMonochrome, isWithLine: isWithLine)
        uiView.configuration = configuration
    }
}

extension SFWView {
    /// Rotates wheel with animation
    /// - Parameter index: stop at Index
    func rotate(to index: Int) {
        sfwControl.startRotationAnimation(finishIndex: index, continuousRotationTime: 1) { isFinished in
            print(index)
        }
    }
}
