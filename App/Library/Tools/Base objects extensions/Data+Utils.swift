//
//  Data+Utils.swift
//  Heap
//
//  Created by Alex Kozin on 21.04.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import Foundation

extension Data {

    var prettySize: String {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .binary
        return formatter.string(fromByteCount: Int64(count))
    }

}

