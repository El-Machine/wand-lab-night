//
//  CollectionItemsDataSource.swift
//  Heap
//
//  Created by Alex Kozin on 29.07.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

class ItemsDataSource<T: Item>: NSObject {

    var items = [T]()

    subscript(index: Int) -> T {
        items[index]
    }

    subscript(indexPath: IndexPath) -> T {
        self[indexPath.row]
    }

    required init(_ items: [T]? = nil) {
        self.items = items ?? []

        super.init()
    }

    func clearSelection() {

    }

    @objc
    func reloadItems() {

    }

    func reloadView() {
    }

}
