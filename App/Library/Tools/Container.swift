//
//  Visible.swift
//  Heap
//
//  Created by Alexander Kozin on 19.06.16.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

extension UIViewController {

    @objc
    var visible: UIViewController? {
        presentedViewController ?? self
    }

    var container: UIViewController? {
        tabBarController ?? navigationController ?? splitViewController
    }

    var isRoot: Bool {
        UIApplication.shared.windows.first?.rootViewController == self
    }

}

extension UINavigationController {

    @objc
    override var visible: UIViewController {
        visibleViewController?.visible ?? self
    }

}

extension UITabBarController {

    @objc
    override var visible: UIViewController {
        selectedViewController?.visible ?? self
    }

}

extension UIApplication {

    var visibleViewController: UIViewController? {
        windows.first?.rootViewController?.visible
    }

    var rootViewController: UIViewController? {
        windows.first?.rootViewController
    }

}
