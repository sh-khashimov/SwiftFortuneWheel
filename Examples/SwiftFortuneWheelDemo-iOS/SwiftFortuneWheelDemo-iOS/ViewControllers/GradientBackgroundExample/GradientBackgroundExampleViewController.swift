//
//  BackgroundGradientExampleViewController.swift
//  SwiftFortuneWheelDemo-iOS
//
//  Created by Sherzod Khashimov on 15/06/21.
//  Copyright © 2021 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class GradientBackgroundExampleViewController: UIViewController {
    
    @IBOutlet weak var gradientTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var gradientDirectionSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var fortuneWheel: SwiftFortuneWheel! {
        didSet {
            fortuneWheel.configuration = .gradientBackgroundExampleConfiguration
        }
    }
    
    private var gradientColor: SFGradientColor {
        let colors: [UIColor] = [.blue, .red]
        let colorLocations: [CGFloat] = [0, 1]
        let gradientType: SFGradientColor.GradientType = gradientTypeSegmentedControl.selectedSegmentIndex == 0 ? .linear : .radial
        let gradientDirection: SFGradientColor.Direction = gradientDirectionSegmentedControl.selectedSegmentIndex == 0 ? .vertical : .horizontal
        return SFGradientColor(colors: colors, colorLocations: colorLocations, type: gradientType, direction: gradientDirection)
    }
    
    private var slices: [Slice] = []
    
    private let sliceCount = 8
    
    func updateSlices() {
        slices = []
        let _gradientColor = self.gradientColor
        for index in 1...sliceCount {
            let headerContent = Slice.ContentType.text(text: "Slicee \(index)", preferences: .gradientBackgroundExampleTextPreferences)
            let slice = Slice(contents: [headerContent], gradientColor: _gradientColor)
            slices.append(slice)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Background Gradient Example"
        
        updateSlices()
        fortuneWheel.slices = slices
    }
    
    @IBAction func gradientValueChanged(_ sender: UISegmentedControl) {
        updateSlices()
        fortuneWheel.slices = slices
    }

}
