//
//  Animation.swift
//  Heap
//
//  Created by Alex Kozin on 02.06.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit


protocol Animations {

    func hide(_ duration: TimeInterval)

}

extension UIView {

    func showAnimated() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }

    func hideAnimated(_ duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.alpha = 0
        }
    }

    func setHiddenAnimated(_ hidden: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.alpha = (!hidden)|
        }
    }

    func hideInBlur(_ completion: (()->())?) {
        let blurView = UIVisualEffectView(effect: UIBlurEffect())
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = bounds

        blurView.alpha = 0

        addSubview(blurView)

        UIView.animate(withDuration: 0.3, animations: {
            blurView.alpha = 1
            self.alpha = 0
        }) { _ in
            blurView.removeFromSuperview()
            completion?()
        }
    }

}

extension Array where Element: UIView {

    func show(_ duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.forEach {
                $0.alpha = 1
            }
        }
    }

    func hide(_ duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration) {
            self.forEach {
                $0.alpha = 0
            }
        }
    }

}
