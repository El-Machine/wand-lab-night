//
//  Color.swift
//  Heap
//
//  Created by Alex Kozin on 16.04.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

struct Theme {

    static let main = UIColor(named: "theme")!

    static func apply() {
        UIView.appearance().tintColor = main
    }

}

extension UIColor {

    static var main: UIColor {
        Theme.main
    }

}
