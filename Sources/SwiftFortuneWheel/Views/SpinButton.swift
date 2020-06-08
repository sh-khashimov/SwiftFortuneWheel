//
//  SpinButton.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
// 
//

import UIKit

/// Spin button located at the center of the fotune wheel view.
/// Optional and can be hidden.
class SpinButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension SpinButton {
    /// Setups auto layouts with preferences
    /// - Parameter preferences: Spin button preferences, that contains layouts preference variables.
    func setupAutoLayout(with preferences: SwiftFortuneWheelConfiguration.SpinButtonPreferences?) {
        guard let superView = self.superview else { return }
        guard let preferences = preferences else { return }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.heightAnchor.constraint(equalToConstant: preferences.size.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: preferences.size.width).isActive = true
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: preferences.horizontalOffset).isActive = true
        self.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: preferences.verticalOffset).isActive = true
    }

    /// Updates spin button image
    /// - Parameter name: Image name from assets catalog
    func image(name: String?) {
        guard let imageName = name else { return }
        let image = UIImage(named: imageName)
        self.setImage(image, for: .normal)
    }

    /// Updates spin button background image
    /// - Parameter name: Image name from assets catalog
    func backgroundImage(name: String?) {
        guard let imageName = name else { return }
        let image = UIImage(named: imageName)
        self.setBackgroundImage(image, for: .normal)
    }

    /// Updates spin button background color and layer
    /// - Parameter preferences: Preferences that contains appearance preference variables.
    func configure(with preferences: SwiftFortuneWheelConfiguration.SpinButtonPreferences?) {
        self.backgroundColor = preferences?.backgroundColor
        self.layer.cornerRadius = preferences?.cornerRadius ?? 0
        self.layer.borderWidth = preferences?.cornerWidth ?? 0
        self.layer.borderColor = preferences?.cornerColor.cgColor
        self.titleLabel?.textColor = preferences?.textColor
        self.titleLabel?.font = preferences?.font
    }
}
