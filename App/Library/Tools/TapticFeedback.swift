//
//  TapticFeedback.swift
//  Heap
//
//  Created by Alex Kozin on 15.04.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

struct TapticFeedback {

    typealias Start = ()->()

    static func fieldSelection() -> Start {
        soft()
    }

    static func fieldError() -> Start {
        notification(.error)
    }

    static func viewControllerPresent() -> Start {
        soft()
    }

    static func viewControllerDismiss() -> Start {
        soft()
    }

    private static func soft(intensity: CGFloat = 0.66) -> Start {
        //DEBUG
        if FeedbackGeneratorViewController.shouldUseLast, let last = FeedbackGeneratorViewController.last {
            return last.restart()
        }
        //

        return UIImpactFeedbackGenerator(style: .adaptiveSoft).start(intensity: intensity)
    }

    private static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) -> Start {
        //DEBUG
        if FeedbackGeneratorViewController.shouldUseLast, let last = FeedbackGeneratorViewController.last {
            return last.restart()
        }
        //

        return UINotificationFeedbackGenerator().start(type: type)
    }

}

extension UIImpactFeedbackGenerator.FeedbackStyle {

    static var adaptiveSoft: Self {
        if #available(iOS 13.0, *) {
            return .soft
        } else {
            return .light
        }
    }

}

extension UIFeedbackGenerator {

    typealias Start = ()->()

    @objc
    func start() -> Start {
        ShoudBeOverriden()
    }

    @objc
    func restart() -> UIFeedbackGenerator.Start {
        ShoudBeOverriden()
    }

}

extension UIImpactFeedbackGenerator {

    struct Var {
        static var intensity: CGFloat = .nan
    }

    override func start() -> UIFeedbackGenerator.Start {
        start(intensity: 1)
    }

    override func restart() -> UIFeedbackGenerator.Start {
        restart(intensity: Var.intensity)
    }

    func start(intensity: CGFloat = .nan) -> UIFeedbackGenerator.Start {
        prepare()

        Var.intensity = intensity

        return {
            if #available(iOS 13.0, *) {
                let targetIntensity = intensity.isNaN ? 1 : intensity
                self.impactOccurred(intensity: targetIntensity)
            } else {
                self.impactOccurred()
            }
        }
    }

    func restart(intensity: CGFloat = .nan) -> UIFeedbackGenerator.Start {
        let intensity = intensity.isNaN ? Var.intensity : intensity
        return start(intensity: intensity)
    }

}

extension UINotificationFeedbackGenerator {

    struct Var {
        static var type: UINotificationFeedbackGenerator.FeedbackType?
    }

    func start(type: UINotificationFeedbackGenerator.FeedbackType) -> UIFeedbackGenerator.Start {
        prepare()

        Var.type = type

        return {
            self.notificationOccurred(type)
        }
    }

    override func restart() -> UIFeedbackGenerator.Start {
        restart(type: Var.type ?? .success)
    }

    func restart(type: UINotificationFeedbackGenerator.FeedbackType) -> UIFeedbackGenerator.Start {
        start(type: type)
    }

}

extension UISelectionFeedbackGenerator {

    override func start() -> UIFeedbackGenerator.Start {
        prepare()

        return {
            self.selectionChanged()
        }
    }

    override func restart() -> UIFeedbackGenerator.Start {
        start()
    }

}
