//
//  LayoutCollectionViewCell.swift
//  SwiftFortuneWheelDemoiOS
//
//  Created by Sherzod Khashimov on 7/8/20.
//  Copyright © 2020 Sherzod Khashimov. All rights reserved.
//

import UIKit

class LayoutCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
}

extension LayoutCollectionViewCell {
    func configure(text: String, imageName: String, backgroundColor: UIColor, textColor: UIColor) {
        self.label.text = text
        self.imageView.image = UIImage(named: imageName)
        self.contentView.backgroundColor = backgroundColor
        label.textColor = textColor
    }
}
