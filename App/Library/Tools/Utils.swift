//
//  Utils.swift
//  Heap
//
//  Created by Alexander Kozin on 11.05.16.
11(
//

import Foundation
import UIKit

class Utils {

    static let executableName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

    static func swiftClass(from className: String) -> AnyClass? {
        return NSClassFromString(executableName + "." + className)
    }

    static func string(_ swiftClass: AnyClass) -> String {
        return String(describing: swiftClass)
    }

    static func dispatchMainSyncSafe(_ block:  () -> Void) {
        if (Thread.isMainThread) {
            block()
        } else {
            DispatchQueue.main.sync(execute: block)
        }
    }
    
}

public func RootViewController() -> UIViewController {
    return UIApplication.shared.delegate!.window!!.rootViewController!
}

public func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func ShoudBeOverriden(function: String = #function) -> Never {
    fatalError("\(function) should be overriden.")
}
