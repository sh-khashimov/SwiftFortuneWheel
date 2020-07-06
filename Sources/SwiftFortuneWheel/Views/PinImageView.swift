//
//  PinImageView.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
// 
//

import UIKit

/// Pin or anchor image view, that usually represents an arrow to point in selected slice.
class PinImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension PinImageView {

    /// Setups auto layouts with preferences
    /// - Parameter preferences: Spin button preferences, that contains layouts preference variables.
    func setupAutoLayout(with preferences: SFWConfiguration.PinImageViewPreferences?) {
        guard let superView = self.superview else { return }
        guard let preferences = preferences else { return }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.heightAnchor.constraint(equalToConstant: preferences.size.height).isActive = true
        self.widthAnchor.constraint(equalToConstant: preferences.size.width).isActive = true

        switch preferences.position {
        case .top:
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: preferences.verticalOffset).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: preferences.verticalOffset).isActive = true
        case .left:
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: preferences.horizontalOffset).isActive = true
        case .right:
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: preferences.horizontalOffset).isActive = true
        }

        switch preferences.position {
        case .top, .bottom:
            self.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: preferences.horizontalOffset).isActive = true
        case .left, .right:
            self.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: preferences.verticalOffset).isActive = true
        }
    }

    /// Updates pin image
    /// - Parameter name: Image name from assets catalog
    func image(name: String?) {
        guard let imageName = name else { return }
        self.image = UIImage(named: imageName)
    }

    /// Updates pin image view background color and layer
    /// - Parameter preferences: Preferences that contains appearance preference variables.
    func configure(with preferences: SFWConfiguration.PinImageViewPreferences?) {
        self.backgroundColor = preferences?.backgroundColor
        self.tintColor = preferences?.tintColor
    }
}
