//
//  GradientView.swift
//  Heap
//
//  Created by Alex Kozin on 28.04.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear

    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: 0,
                                y: 0,
                                width: rect.width,
                                height: rect.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]

        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
    
}
