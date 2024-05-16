//  Copyright (c) 2020-2021 El Machine (http://el-machine.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Alex Kozin
//  2020 El Machine
//

import CoreMotion

import Pipe
import XCTest

class CoreMotion_Tests: XCTestCase {

#if !targetEnvironment(simulator)

    func test_CMPedometerEvent() {
        let e = expectation()
        e.assertForOverFulfill = false

        |{ (event: CMPedometerEvent) in
            e.fulfill()
        }

        waitForExpectations()
    }

    //Test it while walking
//    func test_CMPedometerData() {
//        let e = expectation()
//
//        |{ (location: CMPedometerData) in
//            e.fulfill()
//        }
//
//        waitForExpectations()
//    }

#endif

    func test_CMPedometer() {
        XCTAssertNotNil(nil| as CMPedometer)
    }
}
