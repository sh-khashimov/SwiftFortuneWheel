//
//  VariousWheelJackpotViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/10/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class VariousWheelJackpotViewController: UIViewController {
    
    @IBOutlet weak var wheelBackgroundView: UIView! {
        didSet {
            wheelBackgroundView.layer.cornerRadius = wheelBackgroundView.bounds.width / 2
        }
    }
    
    @IBOutlet weak var wheelControl: SwiftFortuneWheel! {
        didSet {
            wheelControl.configuration = .variousWheelJackpotConfiguration
            wheelControl.slices = slices
            wheelControl.spinImage = "redCenterImage"
            wheelControl.pinImage = "redArrow"
            wheelControl.isSpinEnabled = false
        }
    }
    
    var prizes = [(name: "90 $", color: #colorLiteral(red: 0.5854218602, green: 0.8424194455, blue: 0.2066773474, alpha: 1)),
                  (name: "900 $", color: #colorLiteral(red: 0.7690342069, green: 0.1236859187, blue: 0.4755392671, alpha: 1)),
                  (name: "500 $", color: #colorLiteral(red: 0.9826856256, green: 0.7220065594, blue: 0.05612647533, alpha: 1)),
                  (name: "30 $", color: #colorLiteral(red: 0.2356889248, green: 0.8724163771, blue: 0.85432899, alpha: 1)),
                  (name: "700 $", color: #colorLiteral(red: 0.9794624448, green: 0.6201235652, blue: 0.6958915591, alpha: 1)),
                  (name: "200 $", color: #colorLiteral(red: 0.4257903695, green: 0.6329038739, blue: 0.156085223, alpha: 1)),
                  (name: "50 $", color: #colorLiteral(red: 0.09231997281, green: 0.4172462225, blue: 0.3689391613, alpha: 1)),
                  (name: "60 $", color: #colorLiteral(red: 0.958955586, green: 0.2735637724, blue: 0.4815714359, alpha: 1)),
                  (name: "400 $", color: #colorLiteral(red: 0.1772866547, green: 0.6875243783, blue: 0.6854498386, alpha: 1)),
                  (name: "20 $", color: #colorLiteral(red: 0.9825684428, green: 0.7300174832, blue: 0, alpha: 1)),
                  (name: "100 $", color: #colorLiteral(red: 0.570887804, green: 0.1648567915, blue: 0.1432392001, alpha: 1)),
                  (name: "600 $", color: #colorLiteral(red: 0.9597253203, green: 0.1424967945, blue: 0.004152901471, alpha: 1)),
                  (name: "1000 $", color: #colorLiteral(red: 0.9231320024, green: 0.2861315608, blue: 0.5029468536, alpha: 1)),
                  (name: "70 $", color: #colorLiteral(red: 0.9855783582, green: 0.7895880342, blue: 0.03264886886, alpha: 1)),
                  (name: "800 $", color: #colorLiteral(red: 0.1296649575, green: 0.5344828367, blue: 0.5237221718, alpha: 1)),
                  (name: "40 $", color: #colorLiteral(red: 0.2102268934, green: 0.8189934492, blue: 0.7014687657, alpha: 1)),
                  (name: "300 $", color: #colorLiteral(red: 0.1332196295, green: 0.4960685372, blue: 0.7784749269, alpha: 1)),
                  (name: "10 $", color: #colorLiteral(red: 0.05485288054, green: 0.2538931668, blue: 0.461497426, alpha: 1))]
    
    lazy var slices: [Slice] = {
        
        var slices: [Slice] = []
        
        for prize in prizes {
            let sliceContent = [Slice.ContentType.text(text: prize.name, preferences: .variousWheelJackpotText)]
            let slice = Slice(contents: sliceContent, backgroundColor: prize.color)
            slices.append(slice)
        }
        
        let imagePreferences = ImagePreferences(preferredSize: CGSize(width: 10, height: 60), verticalOffset: 5)
        
        let sliceContent = [Slice.ContentType.assetImage(name: "JACKPOT", preferences: imagePreferences)]
        var sliceJACKPOT = Slice(contents: sliceContent, backgroundColor: .white)
        slices.append(sliceJACKPOT)
        
        return slices
    }()

    var finishIndex: Int {
        return Int.random(in: 0..<wheelControl.slices.count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wheelBackgroundView.layer.cornerRadius = wheelBackgroundView.bounds.width / 2
    }
    
    @IBAction func rotateTap(_ sender: Any) {
        wheelControl.startRotationAnimation(finishIndex: finishIndex, continuousRotationTime: 1) { (finished) in
            print(finished)
        }
    }

}
