//
//  PinImageView.swift
//  SwiftFortuneWheel
//
//  Created by Sherzod Khashimov on 6/3/20.
// 
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Pin or anchor image view, that usually represents an arrow to point in selected slice.
class PinImageView: UIImageView {
    
    private var heightLC: NSLayoutConstraint?
    private var widthLC: NSLayoutConstraint?
    private var topLC: NSLayoutConstraint?
    private var bottomLC: NSLayoutConstraint?
    private var leadingLC: NSLayoutConstraint?
    private var trailingLC: NSLayoutConstraint?
    private var centerXLC: NSLayoutConstraint?
    private var centerYLC: NSLayoutConstraint?
    
}

extension PinImageView {
    
    /// Setups auto layouts with preferences
    /// - Parameter preferences: Spin button preferences, that contains layouts preference variables.
    func setupAutoLayout(with preferences: SFWConfiguration.PinImageViewPreferences?) {
        guard let superView = self.superview else { return }
        guard let preferences = preferences else { return }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        diactivateConstrains()
        
        heightLC = self.heightAnchor.constraint(equalToConstant: preferences.size.height)
        heightLC?.isActive = true
        
        widthLC = self.widthAnchor.constraint(equalToConstant: preferences.size.width)
        widthLC?.isActive = true
        
        switch preferences.position {
        case .top:
            topLC = self.topAnchor.constraint(equalTo: superView.topAnchor, constant: preferences.verticalOffset)
            topLC?.isActive = true
        case .bottom:
            bottomLC = self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: preferences.verticalOffset)
            bottomLC?.isActive = true
        case .left:
            leadingLC = self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: preferences.horizontalOffset)
            leadingLC?.isActive = true
        case .right:
            trailingLC = self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: preferences.horizontalOffset)
            trailingLC?.isActive = true
        }
        
        switch preferences.position {
        case .top, .bottom:
            centerXLC = self.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: preferences.horizontalOffset)
            centerXLC?.isActive = true
        case .left, .right:
            centerYLC = self.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: preferences.verticalOffset)
            centerYLC?.isActive = true
        }
        
        
        self.layoutIfNeeded()
    }
    
    private func diactivateConstrains() {
        heightLC?.isActive = false
        widthLC?.isActive = false
        topLC?.isActive = false
        bottomLC?.isActive = false
        leadingLC?.isActive = false
        trailingLC?.isActive = false
        centerXLC?.isActive = false
        centerYLC?.isActive = false
    }
    
    /// Updates pin image
    /// - Parameter name: Image name from assets catalog
    func image(name: String?) {
        guard let imageName = name, imageName != "" else {
            self.image = nil
            return
        }
        self.image = SFWImage(named: imageName)
    }
    
    /// Updates pin image view background color and layer
    /// - Parameter preferences: Preferences that contains appearance preference variables.
    func configure(with preferences: SFWConfiguration.PinImageViewPreferences?) {
        self.backgroundColor = preferences?.backgroundColor
        self.tintColor = preferences?.tintColor
    }
}
