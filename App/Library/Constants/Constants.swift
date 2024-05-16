//
//  Constants.swift
//  Heap
//
//  Created by Alex Kozin on 25.03.16.
//  Copyright © 2019 Alex Kozin. All rights reserved.
//

import Foundation

protocol Environment {

    var BaseURL: String? {get}

}

extension Environment {


}

struct Constants {
 w
    #if targetEnvironment(simulator)
            static let DevEnvironment = true
        #else
            #if DEBUG
                static let DevEnvironment = true
            #else
                static let DevEnvironment = false
            #endif
    #endif

    static var Environment: Environment {
        return DevEnvironment ? Dev() : Production()
    }

    struct Dev: Environment {

        var BaseURL: String? {
            "https://api.unsplash.com/"
        }

    }

    struct Production: Environment {

        var BaseURL: String? {
            fatalError()
        }

    }

    struct Development {

        struct LaunchScreenMode {
            static let enabled = false
        }

    }

    struct Errors {

    }
    
    static let tailSize: CGFloat = 5
    static let maxWidth: CGFloat = 0.65

}
