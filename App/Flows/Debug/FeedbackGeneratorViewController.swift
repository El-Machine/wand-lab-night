//
//  FeedbackGeneratorViewController.swift
//  Heap
//
//  Created by Alex Kozin on 15.04.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

class FeedbackGeneratorViewController: ViewController {

    static var last: UIFeedbackGenerator?

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lastSwitch: UISwitch!

    static var shouldUseLast = false

    @IBAction func touched(_ sender: UIButton) {
        let style = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: sender.tag)!
        let generator = UIImpactFeedbackGenerator(style: style)

        if #available(iOS 13.0, *) {
            generator.impactOccurred(intensity: CGFloat(slider.value))
        } else {
            generator.impactOccurred()
        }
        FeedbackGeneratorViewController.last = generator
    }

    @IBAction func selection(_ sender: Any) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        FeedbackGeneratorViewController.last = generator
    }

    @IBAction func notification(_ sender: UIButton) {
        let type = UINotificationFeedbackGenerator.FeedbackType(rawValue: sender.tag)!
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
        FeedbackGeneratorViewController.last = generator
    }

    @IBAction func didSlide(_ sender: UISlider) {
        (FeedbackGeneratorViewController.last as? UIImpactFeedbackGenerator)?.restart(intensity: CGFloat(sender.value))()
    }

    @IBAction func didChangeLastSwitch(_ sender: UISwitch) {
        FeedbackGeneratorViewController.shouldUseLast = sender.isOn
    }

    class override var flow: Flow {
        .Debug
    }

}
