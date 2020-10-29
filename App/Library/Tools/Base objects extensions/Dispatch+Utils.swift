//
//  Dispatch+Utils.swift
//  Heap
//
//  Created by Alex Kozin on 03.07.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    private static var _onceTracker = [String]()

    class func once(object: CustomStringConvertible, file: String = #file, function: String = #function, line: Int = #line, block: ()->()) {
        let token = String(describing: object) + file + ":" + function + ":" + String(line)
        once(token: token, block: block)
    }


    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.

     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    class func once<Subject>(token object: Subject, block: ()->()) {
        let token = String(describing: object)
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }

    func after(_ interval: TimeInterval, execute: @escaping () -> Void) -> DispatchWorkItem {
        let item = DispatchWorkItem {
            execute()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: item)
        return item
    }

}
