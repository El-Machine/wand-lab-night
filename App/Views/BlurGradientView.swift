//
//  BlurGradientView.swift
//  Heap
//
//  Created by Alex Kozin on 28.05.2020.
11(
//


//let maskLayer = CAGradientLayer()
//maskLayer.frame = yourImageView.bounds
//maskLayer.shadowRadius = 5
//maskLayer.shadowPath = CGPath(roundedRect: YourImagView.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 10, cornerHeight: 10, transform: nil)
//maskLayer.shadowOpacity = 1
//maskLayer.shadowOffset = CGSize.zero
//maskLayer.shadowColor = UIColor.white.cgColor
//yourImageView.layer.mask = maskLayer


import UIKit

//final class GradientView: UIView {
//
//    override func draw(_ rect: CGRect) {
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = CGRect(x: 0,
//                                y: 0,
//                                width: rect.width,
//                                height: rect.height)
//        gradient.colors = [UIColor.white.cgColor,
//                           UIColor.clear.cgColor]
//
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 0, y: 1)
//        gradient.zPosition = -1
//        layer.addSublayer(gradient)
//    }
//
//}

class BlurGradientView: UIView {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard superview != nil else {
            return
        }

        prepare()
    }

    func prepare() {
        let blur = addBlurView()
        addMask(to: blur)
    }

    func addBlurView() -> UIView {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        return view
    }

    func addMask(to view: UIView) {
        let mask = CAGradientLayer()
        mask.colors = [
            UIColor.white.cgColor,
            UIColor.init(white: 1, alpha: 0).cgColor
        ]

        view.layer.mask = mask
    }

//    override open class var layerClass: AnyClass {
//        CAGradientLayer.classForCoder()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)

//        backgroundColor = UIColor.clear
//    }
//
//    override func draw(_ rect: CGRect) {
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = CGRect(x: 0,
//                                y: 0,
//                                width: rect.width,
//                                height: rect.height)
//        gradient.colors = [UIColor.white.cgColor,
//                           UIColor.clear.cgColor]
//
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 0, y: 1)
//        gradient.zPosition = -1
//        layer.addSublayer(gradient)
//    }

}
