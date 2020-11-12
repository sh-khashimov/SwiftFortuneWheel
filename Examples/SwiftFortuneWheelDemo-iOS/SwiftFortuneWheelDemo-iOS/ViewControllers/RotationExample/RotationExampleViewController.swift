//
//  RotationViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/6/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class RotationExampleViewController: UIViewController {

    @IBOutlet weak var wheelControl: SwiftFortuneWheel! {
        didSet {
            wheelControl.configuration = .rotationExampleConfiguration
            wheelControl.slices = slices
            wheelControl.pinImage = "long-arrow-up-black"
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var keyboardToolbar: UIToolbar!
    
    @IBOutlet weak var rotationStopAtIndexTextField: UITextField!
    @IBOutlet weak var rotationStopAtAngleTextField: UITextField!
    
    let rotationStrings: [String] = ["R", "O", "T", "A", "T", "I", "O", "N"]
    
    lazy var slices: [Slice] = {
        var slices: [Slice] = []
        for index in 0...7 {
            let headerContent = Slice.ContentType.text(text: "\(index)", preferences: .rotationExampleAmountTextPreferences)
            let descriptionContent = Slice.ContentType.text(text: rotationStrings[index], preferences: .rotationExampleDescriptionTextPreferences)
            let slice = Slice(contents: [headerContent, descriptionContent])
            slices.append(slice)
        }
        return slices
    }()
    
    var rotationStopAtIndex: Int {
        guard let index = Int(rotationStopAtIndexTextField.text ?? "") else { return 0 }
        guard index < wheelControl.slices.count else { return wheelControl.slices.count - 1 }
        return index
    }
    
    var rotationStopAtAngle: Int {
        guard let index = Int(rotationStopAtAngleTextField.text ?? "") else { return 0 }
        return index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Rotation and Animation API Example"

        rotationStopAtIndexTextField.inputAccessoryView = keyboardToolbar
        rotationStopAtAngleTextField.inputAccessoryView = keyboardToolbar
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height + 20 - view.safeAreaInsets.bottom, right: 0)
        }

        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    @IBAction func rotateWithIndexStopTap(_ sender: Any) {
        wheelControl.rotate(toIndex: rotationStopAtIndex)
    }
    
    @IBAction func rotateWithAngleStopTap(_ sender: Any) {
        wheelControl.rotate(rotationOffset: CGFloat(rotationStopAtAngle))
    }

    @IBAction func rotationStopAtIndexValueChange(_ sender: Any) {
        rotationStopAtIndexTextField.text = "\(rotationStopAtIndex)"
    }

    @IBAction func rotationStopAtAngleValueChange(_ sender: Any) {
        rotationStopAtAngleTextField.text = "\(rotationStopAtAngle)"
    }

    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }

}
