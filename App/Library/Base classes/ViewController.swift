//
//  BaseViewController.swift
//  Heap
//
//  Created by Alex Kozin on 12.01.16.
//  Copyright © 2019 Alex Kozin. All rights reserved.
//

import UIKit

protocol ViewControllerInterface: UIAdaptivePresentationControllerDelegate {

    var pullIndicator: UIView? { get }

    func prepare()

    func setPullIndicator(hidden: Bool, animated: Bool)

    func modalWillDismiss()
    func modalDidDismiss()

}

extension ViewControllerInterface {

    func setPullIndicator(hidden: Bool, animated: Bool = true) {
        let block: ()->Void = {
            self.pullIndicator?.alpha = (!hidden)| - 0.4
        }

        if hidden {
            UIView.animate(withDuration: 0.9,
                           delay: 0,
                           options: [.curveEaseOut],
                           animations: block)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.curveEaseOut],
                           animations: block)
        }
    }

}

class ViewController: UIViewController, ViewControllerInterface {

    weak var top: ViewControllerInterface?

    @IBOutlet weak var pullIndicator: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }

    func prepare() {
        presentationController?.delegate = self
    }

    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {

        top = presentingViewController as? ViewControllerInterface

        transitionCoordinator?.animate(alongsideTransition: { _ in
            self.top?.setPullIndicator(hidden: true)
        })
    }

    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        allowsDismissDrag
    }

    var allowsDismissDrag: Bool {
        true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        top?.modalWillDismiss()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        top?.modalDidDismiss()
    }

    func modalWillDismiss() {

    }

    func modalDidDismiss() {
        setPullIndicator(hidden: false)
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        .slide
    }

    override var prefersStatusBarHidden: Bool {
        parent?.prefersStatusBarHidden ?? false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}

class TabBarController: UITabBarController, ViewControllerInterface {

    @IBOutlet var pullIndicator:  UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }

    func prepare() {

    }

    func modalWillDismiss() {
        
    }

    func modalDidDismiss() {
        viewControllers?.forEach {
            ($0 as? ViewController)?.modalDidDismiss()
        }
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        .slide
    }

}

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
    }

    func prepare() {

    }

    func modalDidDismiss() {

    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        .slide
    }

}
