//
//  UIViewController+Storyboards.swift
//  Heap
//
//  Created by Alexander Kozin on 12.05.16.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

@objc
enum Flow: Int {
    
    case Main, Debug, Edit, Order

    var name: String {
        switch self {
            case .Main:
                return "Main"
            case .Debug:
                return "Debug"
            case .Edit:
                return "Edit"
            case .Order:
                return "Order"
        }
    }

}

extension UIViewController {

    static func inNavigationStack() -> UIViewController {
        UINavigationController(rootViewController: controller())
    }

    static func controller() -> Self {
        storyboard().instantiateViewController(withIdentifier: storyboardIdentifier()) as! Self
    }

    static func initial() -> UIViewController {
        storyboard().instantiateInitialViewController()!
    }

    class func storyboard() -> UIStoryboard {
        UIStoryboard(name: flow.name, bundle: nil)
    }

    class func storyboardIdentifier() -> String {
        return Utils.string(self)
    }

    @objc
    class var flow: Flow {
        .Main
    }

}

extension UIViewController {

    @objc
    @IBAction func back() {
        let popped = navigationController?.popViewController(animated: true)
        if popped == nil {
            dismiss()
        }
    }

    @IBAction func prepareForUnwind(_ segue: UIStoryboardSegue) {

    }

    func unwind() {
        self.performSegue(withIdentifier: "unwind", sender: self)
    }

    func present(_ viewControllerToPresent: UIViewController, completion: (() -> Void)? = nil) {
        present(viewControllerToPresent, animated: true, completion: completion)
    }

    func show(animated: Bool = true) {
        visible?.present(self, animated: animated)
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func dismiss(completion: (() -> Swift.Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }

}
