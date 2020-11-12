//
//  BackgroundImageExampleViewController.swift
//  SwiftFortuneWheelDemo-iOS
//
//  Created by Sherzod Khashimov on 11/10/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class BackgroundImageExampleViewController: UIViewController {
    
    @IBOutlet weak var imageTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var fortuneWheel: SwiftFortuneWheel! {
        didSet {
            fortuneWheel.configuration = .backgroundImageExampleConfiguration
            fortuneWheel.slices = slices
        }
    }
    
    lazy var slices: [Slice] = {
        var slices: [Slice] = []
        for index in 0..<sliceStrings.count {
            let headerContent = Slice.ContentType.text(text: "IMAGE \(index)", preferences: .backgroundImageExampleAmountTextPreferences)
            let descriptionContent = Slice.ContentType.text(text: sliceStrings[index].name, preferences: .backgroundImageExampleDescriptionTextPreferences)
            let image = SFWImage(named: sliceStrings[index].filename)
            let slice = Slice(contents: [headerContent, descriptionContent],backgroundImage: image)
            slices.append(slice)
        }
        return slices
    }()
    
    let sliceStrings: [(name: String, filename: String)] = [(name: "Orange", filename: "orange_3d_geometric_abstract_background_6815666"), (name: "Modern", filename: "modern-colorful-background_1035-3255"), (name: "Layered 1", filename: "layered_colored_modern_background_vector_587001"), (name: "Layered 2", filename: "layered_colored_modern_background_vector_586963"), (name: "Layered 3", filename: "layered_colored_modern_background_vector_586960"), (name: "Geometric", filename: "Geometric-Background-Colorful-Vector"), (name: "Colorful", filename: "Colorful-Plait-Background"), (name: "Abstract", filename: "abstract-geometric-background-with-a-3d-kjpargeter")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Background Image Example"
    }
    
    @IBAction func imageTypeValueChanged(_ sender: UISegmentedControl) {
        fortuneWheel.configuration?.wheelPreferences.slicePreferences.backgroundImageContentMode = imageTypeSegmentedControl.selectedSegmentIndex == 0 ? .scaleAspectFill : .bottom
    }

}
