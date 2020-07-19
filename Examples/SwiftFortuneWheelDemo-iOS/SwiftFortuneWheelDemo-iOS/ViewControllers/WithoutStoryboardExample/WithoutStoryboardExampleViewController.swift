//
//  Example2ViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/25/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class WithoutStoryboardExampleViewController: UIViewController {
    
    lazy var slices: [Slice] = {
        var slices: [Slice] = []
        for index in 1...4 {
            let headerContent = Slice.ContentType.text(text: "\(index)", preferences: .withoutStoryboardExampleAmountTextPreferences)
            let descriptionContent = Slice.ContentType.text(text: "DESCRIPTION", preferences: .withoutStoryboardExampleDescriptionTextPreferences)
            let slice = Slice(contents: [headerContent, descriptionContent])
            slices.append(slice)
        }
        return slices
    }()

    lazy var fortuneWheel: SwiftFortuneWheel = {
        let frame = CGRect(x: 35, y: 100, width: 300, height: 300)
        let fortuneWheel = SwiftFortuneWheel(frame: frame, slices: slices, configuration: .withoutStoryboardExampleConfiguration)

        return fortuneWheel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Without Storyboard Example"

        view.addSubview(fortuneWheel)
        layoutWheel()

    }

    func layoutWheel() {
        guard let superview = fortuneWheel.superview else { return }
        fortuneWheel.translatesAutoresizingMaskIntoConstraints = false
        fortuneWheel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        fortuneWheel.heightAnchor.constraint(equalToConstant: 300).isActive = true
        fortuneWheel.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        fortuneWheel.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
}
