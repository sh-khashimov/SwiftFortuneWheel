//
//  ExampleViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/7/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class DynamicContentViewExampleController: UIViewController {

    @IBOutlet weak var drawCurvedLineSwitch: UISwitch!
    @IBOutlet weak var colorsTypeSegment: UISegmentedControl!

    @IBOutlet weak var fortuneWheel: SwiftFortuneWheel! {
        didSet {
            fortuneWheel.onSpinButtonTap = { [weak self] in
                self?.startAnimating()
            }
        }
    }

    var prizes: [Prize] = []

    var drawCurvedLine: Bool = false {
        didSet {
            updateSlices()
        }
    }

    var minimumPrize: Int {
        return 0
    }

    var maximumPrize: Int {
        return 12
    }

    var finishIndex: Int {
        return Int.random(in: 0..<fortuneWheel.slices.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = "Dynamic Content Example"

        drawCurvedLine = drawCurvedLineSwitch.isOn

        prizes.append(Prize(amount: 100, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 200, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 300, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 400, description: "Prize".uppercased(), priceType: .money))

        updateSlices()

        fortuneWheel.configuration = .blackCyanColorsConfiguration
    }

    @IBAction func colorsTypeValueChanged(_ sender: Any) {
        switch colorsTypeSegment.selectedSegmentIndex {
        case 1:
            fortuneWheel.configuration = .rainbowColorsConfiguration
        default:
            fortuneWheel.configuration = .blackCyanColorsConfiguration
        }
        updateSlices()
    }

    @IBAction func addPrizeAction(_ sender: Any) {
        guard prizes.count < maximumPrize - 1 else { return }
        let price = Prize(amount: (prizes.count + 1) * 100, description: "Prize".uppercased(), priceType: .money)
        prizes.append(price)

        updateSlices()
    }

    @IBAction func removePrizeAction(_ sender: Any) {
        guard prizes.count > minimumPrize else { return }
        _ = prizes.popLast()

        updateSlices()
    }

    @IBAction func drawCurverLineSwitchChanged(_ sender: UISwitch) {
        drawCurvedLine = sender.isOn
    }


    func updateSlices() {
        let slices: [Slice] = prizes.map({ Slice(contents: $0.sliceContentTypes(isMonotone: colorsTypeSegment.selectedSegmentIndex == 1, withLine: drawCurvedLine)) })

        fortuneWheel.slices = slices

        if prizes.count == maximumPrize - 1 {
            let imageSliceContent = Slice.ContentType.assetImage(name: "crown", preferences: ImagePreferences(preferredSize: CGSize(width: 40, height: 40), verticalOffset: 40))
            var slice = Slice(contents: [imageSliceContent])
            if drawCurvedLine {
                let linePreferences = LinePreferences(colorType: .customPatternColors(colors: nil, defaultColor: .black), height: 2, verticalOffset: 35)
                let line = Slice.ContentType.line(preferences: linePreferences)
                slice.contents.append(line)
            }
            fortuneWheel.slices.append(slice)
        }
    }

    func startAnimating() {
        fortuneWheel.startRotationAnimation(finishIndex: finishIndex, continuousRotationTime: 1) { (finished) in
            print(finished)
        }
    }

}
