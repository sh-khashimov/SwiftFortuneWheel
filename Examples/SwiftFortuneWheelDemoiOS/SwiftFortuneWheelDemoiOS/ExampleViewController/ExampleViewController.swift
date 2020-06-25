//
//  ExampleViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 6/7/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class ExampleViewController: UIViewController {

    @IBOutlet weak var drawCurvedLineSwitch: UISwitch!
    @IBOutlet weak var colorsTypeSegment: UISegmentedControl!

    @IBOutlet weak var fortuneWheel: SwiftFortuneWheel! {
        didSet {
            fortuneWheel.onSpinButtonTap = { [weak self] in
                self?.startAnimating()
            }
        }
    }

    @IBOutlet weak var keyboardToolbar: UIToolbar!

    var prizes: [Prize] = []

    var drawCurvedLine: Bool = false {
        didSet {
            updateSlices()
        }
    }

    var minimumPrize: Int {
        return 4
    }

    var maximumPrize: Int {
        return 12
    }

    var finishIndex: Int {
        guard let index = Int(selectedIndexTextField.text ?? "") else { return 0 }
        guard index < fortuneWheel.slices.count else { return fortuneWheel.slices.count - 1 }
        return index
    }

    @IBOutlet weak var selectedIndexTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = "Example"

        selectedIndexTextField.inputAccessoryView = keyboardToolbar

        drawCurvedLine = drawCurvedLineSwitch.isOn

        prizes.append(Prize(amount: 100, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 200, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 300, description: "Prize".uppercased(), priceType: .money))
        prizes.append(Prize(amount: 400, description: "Prize".uppercased(), priceType: .money))

        updateSlices()

        fortuneWheel.configuration = .exampleWithBlackCyanColorsConfiguration
    }

    @IBAction func colorsTypeValueChanged(_ sender: Any) {
        switch colorsTypeSegment.selectedSegmentIndex {
        case 1:
            fortuneWheel.configuration = .exampleWithRainbowColorsConfiguration
        default:
            fortuneWheel.configuration = .exampleWithBlackCyanColorsConfiguration
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

    @IBAction func selectedIndexValueChange(_ sender: Any) {
        selectedIndexTextField.text = "\(finishIndex)"
    }

    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }


    func updateSlices() {
        let slices: [Slice] = prizes.map({ Slice(contents: $0.sliceContentTypes(isMonotone: colorsTypeSegment.selectedSegmentIndex == 1, withLine: drawCurvedLine)) })

        fortuneWheel.slices = slices

        if prizes.count == maximumPrize - 1 {
            let imageSliceContent = Slice.ContentType.image(name: "crown", preferenes: ImagePreferences(preferredSize: CGSize(width: 40, height: 40), verticalOffset: 40))
            var slice = Slice(contents: [imageSliceContent])
            if drawCurvedLine {
                let linePreferences = LinePreferences(colorType: .customPatternColors(colors: nil, defaultColor: .black), height: 2, verticalOffset: 35)
                let line = Slice.ContentType.line(preferenes: linePreferences)
                slice.contents.append(line)
            }
            fortuneWheel.slices.append(slice)
        }
    }

    func startAnimating() {
        fortuneWheel.startAnimating(fullRotationTimeInSeconds: 1, finishIndex: finishIndex) { (finished) in
            print(finished)
        }
    }

}
