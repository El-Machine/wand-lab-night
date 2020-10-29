//
//  Rounded.swift
//  Heap
//
//  Created by Alex Kozin on 01.06.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

class UIButtonRounded: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }

}

class RoundedBlurView: UIVisualEffectView {

    override func awakeFromNib() {
        layer.cornerRadius = 14
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}

class RoundedView: UIView {

    override func awakeFromNib() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }

}
