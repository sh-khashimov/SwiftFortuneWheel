//
//  Example2ViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/25/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class Example2ViewController: UIViewController {

    lazy var fortuneWheel: SwiftFortuneWheel = {
        var slices: [Slice] = []

        for index in 1...4 {
            let headerContent = Slice.ContentType.text(text: "\(index)", preferences: .example2AmountTextPreferences)
            let descriptionContent = Slice.ContentType.text(text: "DESCRIPTION", preferences: .example2DescriptionTextPreferences)
            let slice = Slice(contents: [headerContent, descriptionContent])
            slices.append(slice)
        }

        let frame = CGRect(x: 35, y: 100, width: 300, height: 300)

        let fortuneWheel = SwiftFortuneWheel(frame: frame, slices: slices, configuration: .example2Configuration)

        fortuneWheel.isPinHidden = true
        fortuneWheel.isSpinHidden = true
        
        fortuneWheel.pinImage = "long-arrow-up"

        fortuneWheel.onSpinButtonTap = { [weak self] in
            self?.rotate()
        }

        return fortuneWheel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Example2"

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

    func rotate() {
        fortuneWheel.rotate(toIndex: 1)
    }
}
