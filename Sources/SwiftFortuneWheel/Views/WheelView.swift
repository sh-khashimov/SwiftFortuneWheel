//
//  WheelView.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
//
//

import UIKit

/// Wheel view with slices.
class WheelView: UIView {

    /// Wheel layer
    private(set) var wheelLayer: WheelLayer?

    /// Customizable preferences.
    /// Required in order to draw properly.
    var preferences: SFWConfiguration.WheelPreferences? {
        didSet {
            wheelLayer = nil
            addWheelLayer()
        }
    }

    /// List of Slice objects.
    /// Used to draw content.
    var slices: [Slice] = [] {
        didSet {
            wheelLayer?.slices = slices
            self.setNeedsDisplay()
        }
    }

    /// Initiates without IB.
    /// - Parameters:
    ///   - frame: Frame
    ///   - slices: List of Slices
    ///   - configuration: Customizable configuration   
    init(frame: CGRect, slices: [Slice], preferences: SFWConfiguration.WheelPreferences?) {
        self.preferences = preferences
        self.slices = slices
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        addWheelLayer()
    }


    /// Updates wheel layer and adds to view layer.
    private func addWheelLayer() {
        for layer in self.layer.sublayers ?? [] {
            layer.removeFromSuperlayer()
        }
        wheelLayer = WheelLayer(frame: self.bounds, slices: self.slices, preferences: preferences)
        self.layer.addSublayer(wheelLayer!)
        wheelLayer!.setNeedsDisplay()
    }

}

extension WheelView {
    /// Setups auto layouts
    func setupAutoLayout() {
        guard let superView = self.superview else { return }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
    }
}
