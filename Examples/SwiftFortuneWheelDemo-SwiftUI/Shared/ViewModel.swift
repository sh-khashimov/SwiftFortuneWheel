//
//  ViewModel.swift
//  SwiftFortuneWheelDemoSwiftUI
//
//  Created by Sherzod Khashimov on 08/01/22.
//

import Foundation
import SwiftFortuneWheel
import Combine

class ViewModel: ObservableObject {
    
    /// Array of prizes
    @Published var prizes: [Prize] = [] {
        didSet {
            self.shouldRedraw.send(true)
        }
    }
    
    /// Configurator for SwiftFortuneWheel, customizes appearance
    @Published var wheelConfiguration: SFWConfiguration = .blackCyanColorsConfiguration {
        didSet {
            self.shouldRedraw.send(true)
        }
    }
    
    /// Should draw a line or not on SwiftFortuneWheel
    @Published var drawCurvedLine: Bool = false {
        didSet {
            self.shouldRedraw.send(true)
        }
    }
    
    /// Responsible for whether the text should be the black color everywhere or not
    @Published var isMonochrome: Bool = false {
        didSet {
            self.shouldRedraw.send(true)
        }
    }
    
    /// Used to bind to the segment index
    @Published var colorIndex = 0 {
        didSet {
            isMonochrome = colorIndex == 1
            wheelConfiguration = colorIndex == 0 ? .blackCyanColorsConfiguration : .rainbowColorsConfiguration
        }
    }
    
    /// Used to bind to the TextField text
    /// Spinning of wheel will stop on the finishIndex
    @Published var finishIndex: Int = 0
    
    /// On spin button tap
    @Published var onRotateTap: (() -> Void)?
    
    /// Will rotate the wheel to specified index
    let rotateToIndex = PassthroughSubject<Int, Never>()
    /// Will redraw the wheel
    let shouldRedraw = PassthroughSubject<Bool, Never>()
    
    /// Minimum prizes size
    let minimumPrize: Int = 0
    /// Maximum prizes size
    var maximumPrize: Int = 12
    
    init() {
        prizes.append(Prize(amount: 100, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 200, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 300, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 400, description: "Prize".uppercased(), priceType: .money))
        
        onRotateTap = {
            self.finishIndex = self.prizes.randomIndex()
            self.rotateToIndex.send(self.finishIndex)
        }
    }
    
    /// Increase prizes size by one
    func increasePrize() {
        guard prizes.count < maximumPrize - 1 else { return }
        let price = Prize(amount: (prizes.count + 1) * 100, description: "Prize".uppercased(), priceType: .money)
        prizes.append(price)
    }
    
    /// Decrease prizes size by one
    func decreasePrize() {
        guard prizes.count > minimumPrize else { return }
        _ = prizes.popLast()
    }
    
}
