//
//  TransparentScrollView.swift
//  TankUpDriver
//
//  Created by Alex Kozin on 20/06/2019.
//  Copyright © 2019 el-machine. All rights reserved.
//

import UIKit

class TransparentScrollView: UIScrollView {

    var viewBeyond: UIView {
        (delegate as! UIViewController).presentingViewController!.view
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let contentView = subviews.last!
        if contentView.point(inside: contentView.convert(point, from: self), with: event) {
            return super.hitTest(point, with: event)
        } else {
            return viewBeyond.hitTest(point, with: event)
        }
    }

}
