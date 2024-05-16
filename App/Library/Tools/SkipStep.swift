//
//  SkipStep.swift
//  Heap
//
//  Created by Alex Kozin on 07.08.17.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

func DebugSkipStep(block: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: block)
}

extension ViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        #if DEBUG
        DispatchQueue.once(object: self) {
            DebugSkipStep {
                self.skipStep()
            }
        }
        #endif
    }

    @objc func skipStep() {
    }

}

extension TabBarController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        #if DEBUG
        DispatchQueue.once(object: self) {
            DebugSkipStep {
                self.skipStep()
            }
        }
        #endif
    }

    @objc func skipStep() {
    }

}

#if DEBUG

//Sign in
#if true

extension MainViewController {

    override func skipStep() {
        showAddController(with: #imageLiteral(resourceName: "screen"))
    }

}

extension AddViewController {

    override func skipStep() {
//        authTouched(self)
    }

}

extension AuthViewController {

    override func skipStep() {
//        phoneField.text = "+79232323550"
//        authorize()
    }

}


#endif

#endif
