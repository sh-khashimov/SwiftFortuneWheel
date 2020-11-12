//
//  RotationExampleViewController.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/6/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit
import SwiftFortuneWheel

class AnimatedRotationExampleViewController: UIViewController {

    @IBOutlet weak var wheelControl: SwiftFortuneWheel! {
        didSet {
            wheelControl.configuration = .rotationExampleConfiguration
            wheelControl.slices = slices
            wheelControl.pinImage = "long-arrow-up-black"
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var keyboardToolbar: UIToolbar!
    
    @IBOutlet weak var keyboardToolbarLabel: UILabel!
    
    @IBOutlet weak var rotationStopAtIndexTextField: UITextField!
    @IBOutlet weak var rotationStopAtAngleTextField: UITextField!
    @IBOutlet weak var indefiniteRotationTimeTextField: UITextField!
    @IBOutlet weak var indefiniteRotationStopAtIndexTextField: UITextField!
    
    @IBOutlet weak var fullRotationUntilFinishTextField: UITextField!
    @IBOutlet weak var animationDurationTextField: UITextField!
    
    private var selectedTextfield: UITextField?
    
    let rotationStrings: [String] = ["R", "O", "T", "A", "T", "I", "O", "N"]
    
    var animationSuccess: Bool?
    
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
    
    var indefiniteRotationStopAtIndex: Int {
        guard let index = Int(indefiniteRotationStopAtIndexTextField.text ?? "") else { return 0 }
        guard index < wheelControl.slices.count else { return wheelControl.slices.count - 1 }
        return index
    }
    
    var indefiniteRotationTime: Int {
        guard let index = Int(indefiniteRotationTimeTextField.text ?? "") else { return 0 }
        return index
    }
    
    var fullRotationsCount: Int {
        guard let index = Int(fullRotationUntilFinishTextField.text ?? "") else { return 13 }
        return index
    }
    
    var animationDuration: Int {
        guard let index = Int(animationDurationTextField.text ?? "") else { return 5 }
        return index
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Rotation and Animation API Example"

        rotationStopAtIndexTextField.inputAccessoryView = keyboardToolbar
        rotationStopAtAngleTextField.inputAccessoryView = keyboardToolbar
        indefiniteRotationTimeTextField.inputAccessoryView = keyboardToolbar
        indefiniteRotationStopAtIndexTextField.inputAccessoryView = keyboardToolbar
        fullRotationUntilFinishTextField.inputAccessoryView = keyboardToolbar
        animationDurationTextField.inputAccessoryView = keyboardToolbar
        
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
    
    @IBAction func startAnimatingTap(_ sender: Any) {
        wheelControl.startContinuousRotationAnimation()
    }
    
    @IBAction func stopAnimatingTap(_ sender: Any) {
        wheelControl.stopRotation()
    }

    @IBAction func startAnimatingWithIndexStopTap(_ sender: Any) {
        let _animationDuration = CFTimeInterval(integerLiteral: Int64(animationDuration))
        wheelControl.startRotationAnimation(finishIndex: rotationStopAtIndex, fullRotationsCount: fullRotationsCount, animationDuration: _animationDuration) { (success) in
            //
        }
    }
    
    @IBAction func startAnimatingWithAngleStopTap(_ sender: Any) {
        wheelControl.startRotationAnimation(rotationOffset: CGFloat(rotationStopAtAngle), fullRotationsCount: fullRotationsCount, animationDuration: CFTimeInterval(animationDuration)) { (success) in
            //
        }
    }
    
    @IBAction func startIndefiniteRotationAndStopTap(_ sender: Any) {
        wheelControl.startRotationAnimation(finishIndex: indefiniteRotationStopAtIndex, continuousRotationTime: indefiniteRotationTime) { (success) in
            //
        }
    }

    @IBAction func rotationStopAtIndexValueChange(_ sender: Any) {
        rotationStopAtIndexTextField.text = "\(rotationStopAtIndex)"
    }

    @IBAction func rotationStopAtAngleValueChange(_ sender: Any) {
        rotationStopAtAngleTextField.text = "\(rotationStopAtAngle)"
    }

    @IBAction func indefiniteRotationStopAtIndexValueChange(_ sender: Any) {
        indefiniteRotationStopAtIndexTextField.text = "\(indefiniteRotationStopAtIndex)"
    }

    @IBAction func indefiniteRotationTimeValueChange(_ sender: Any) {
        indefiniteRotationTimeTextField.text = "\(indefiniteRotationTime)"
    }

    @IBAction func fullRotationUntilFinishValueChange(_ sender: Any) {
        fullRotationUntilFinishTextField.text = "\(fullRotationsCount)"
    }

    @IBAction func animationDurationValueChange(_ sender: Any) {
        animationDurationTextField.text = "\(animationDuration)"
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        keyboardToolbarLabel.text = sender.text
    }
    

    @IBAction func closeKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
}


extension AnimatedRotationExampleViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextfield = textField
        keyboardToolbarLabel.text = textField.text
    }
}
