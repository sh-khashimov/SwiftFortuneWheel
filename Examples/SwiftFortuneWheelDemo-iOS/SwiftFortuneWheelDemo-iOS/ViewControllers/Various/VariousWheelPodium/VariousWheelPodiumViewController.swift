//
//  VariousWheelPodiumViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/10/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class VariousWheelPodiumViewController: UIViewController {
    
    @IBOutlet weak var wheelControl: SwiftFortuneWheel! {
        didSet {
            wheelControl.configuration = .variousWheelPodiumConfiguration
            wheelControl.slices = slices
            wheelControl.spinImage = "darkBlueCenterImage"
            wheelControl.isSpinEnabled = false
        }
    }
    
    var prizes = [(name: "MONEY", color: #colorLiteral(red: 0.8979414105, green: 0.8980956078, blue: 0.8979316354, alpha: 1), imageName: "dollarIcon", textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  (name: "GRAPHIC", color: #colorLiteral(red: 1, green: 0.5892302394, blue: 0.3198351264, alpha: 1), imageName: "graphIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "HOME", color: #colorLiteral(red: 0.9898706079, green: 0.9671228528, blue: 0.4056283832, alpha: 1), imageName: "homeIcon", textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  (name: "IDEA", color: #colorLiteral(red: 0.4118881524, green: 1, blue: 0.6970380545, alpha: 1), imageName: "ideaIcon", textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  (name: "MANAGMENT", color: #colorLiteral(red: 0.3255994916, green: 0.7100547552, blue: 0.9348809719, alpha: 1), imageName: "managerIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "SEARCH", color: #colorLiteral(red: 0.3287895918, green: 0.3738358617, blue: 0.8356924653, alpha: 1), imageName: "searchIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "TARGET", color: #colorLiteral(red: 0.915895164, green: 0.5538236499, blue: 0.9093081355, alpha: 1), imageName: "targetIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "TIME", color: #colorLiteral(red: 0.8828339577, green: 0.3921767175, blue: 0.4065475464, alpha: 1), imageName: "timeIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "MONEY", color: #colorLiteral(red: 0.3568204641, green: 0.3568871021, blue: 0.356816262, alpha: 1), imageName: "dollarIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "GRAPHIC", color: #colorLiteral(red: 1, green: 0.5892302394, blue: 0.3198351264, alpha: 1), imageName: "graphIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "HOME", color: #colorLiteral(red: 0.9898706079, green: 0.9671228528, blue: 0.4056283832, alpha: 1), imageName: "homeIcon", textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  (name: "IDEA", color: #colorLiteral(red: 0.4118881524, green: 1, blue: 0.6970380545, alpha: 1), imageName: "ideaIcon", textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                  (name: "MANAGMENT", color: #colorLiteral(red: 0.3255994916, green: 0.7100547552, blue: 0.9348809719, alpha: 1), imageName: "managerIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "SEARCH", color: #colorLiteral(red: 0.3287895918, green: 0.3738358617, blue: 0.8356924653, alpha: 1), imageName: "searchIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "TARGET", color: #colorLiteral(red: 0.915895164, green: 0.5538236499, blue: 0.9093081355, alpha: 1), imageName: "targetIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),
                  (name: "TIME", color: #colorLiteral(red: 0.8828339577, green: 0.3921767175, blue: 0.4065475464, alpha: 1), imageName: "timeIcon", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]
    
    lazy var slices: [Slice] = {
        var slices: [Slice] = []
        for prize in prizes {
            let sliceContent = [Slice.ContentType.assetImage(name: prize.imageName, preferences: .variousWheelPodiumImage),
                                Slice.ContentType.text(text: prize.name, preferences: .variousWheelPodiumText(textColor: prize.textColor))]
            var slice = Slice(contents: sliceContent, backgroundColor: prize.color)
            slices.append(slice)
        }
        return slices
    }()

    var finishIndex: Int {
        return Int.random(in: 0..<wheelControl.slices.count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func rotateTap(_ sender: Any) {
        wheelControl.startRotationAnimation(finishIndex: finishIndex, continuousRotationTime: 1) { (finished) in
            print(finished)
        }
    }

}
