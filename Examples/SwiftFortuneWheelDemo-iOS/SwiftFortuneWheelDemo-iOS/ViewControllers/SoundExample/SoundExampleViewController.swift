//
//  SoundExampleViewController.swift
//  SwiftFortuneWheelDemo-iOS
//
//  Created by Sherzod Khashimov on 11/10/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class SoundExampleViewController: UIViewController {

    @IBOutlet weak var soundEffectTypeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var impactFeedbackSwitch: UISwitch!
    
    @IBOutlet weak var fortuneWheel: SwiftFortuneWheel! {
        didSet {
            fortuneWheel.configuration = .soundExampleConfiguration
            fortuneWheel.slices = slices
            
            fortuneWheel.impactFeedbackOn = true
            
            fortuneWheel.onEdgeCollision = { progress in
                print("edge collision progress: \(String(describing: progress))")
            }
            
            fortuneWheel.edgeCollisionSound = AudioFile(filename: "Click", extensionName: "mp3")
            
            fortuneWheel.centerCollisionSound = AudioFile(filename: "Tick", extensionName: "mp3")
            
            fortuneWheel.onCenterCollision = { progress in
                print("center collision progress: \(String(describing: progress))")
            }
            
            fortuneWheel.edgeCollisionDetectionOn = true
            
            fortuneWheel.configuration?.wheelPreferences.imageAnchor = SoundExampleViewController.soundExampleImageAnchor
            
            fortuneWheel.onSpinButtonTap = { [weak self] in
                self?.rotate()
            }
        }
    }
    
    lazy var slices: [Slice] = {
        var slices: [Slice] = []
        for index in 0...7 {
            let headerContent = Slice.ContentType.text(text: "Sound", preferences: .soundExampleAmountTextPreferences)
            let descriptionContent = Slice.ContentType.text(text: "Example", preferences: .soundExampleDescriptionTextPreferences)
            let slice = Slice(contents: [headerContent, descriptionContent])
            slices.append(slice)
        }
        return slices
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sound Effect Example"
    }
    
    func rotate() {
        fortuneWheel.startRotationAnimation(finishIndex: 0, continuousRotationTime: 5, nil)
    }
    
    @IBAction func impactFeedbackValueChanged(_ sender: UISwitch) {
        fortuneWheel.impactFeedbackOn = impactFeedbackSwitch.isOn
    }
    
    @IBAction func soundEffectTypeValueChanged(_ sender: UISegmentedControl) {
        fortuneWheel.edgeCollisionDetectionOn = soundEffectTypeSegmentedControl.selectedSegmentIndex == 0
        
        fortuneWheel.centerCollisionDetectionOn = soundEffectTypeSegmentedControl.selectedSegmentIndex == 1
        
        
        fortuneWheel.configuration?.wheelPreferences.imageAnchor =  soundEffectTypeSegmentedControl.selectedSegmentIndex == 0 ?  SoundExampleViewController.soundExampleImageAnchor : nil
        
        fortuneWheel.configuration?.wheelPreferences.centerImageAnchor =  soundEffectTypeSegmentedControl.selectedSegmentIndex == 1 ?  SoundExampleViewController.soundExampleImageAnchor : nil
    }

}
