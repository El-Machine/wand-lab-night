//
//  ItemsTableController.swift
//  Heap
//
//  Created by Alex Kozin.
//  Copyright (c) 2013 General Rhetoric Ltd. All rights reserved.
//

import UIKit

class ItemsController<T: Item>: ViewController {

    var items = [T]()

    subscript(index: Int) -> T {
        items[index]
    }


    subscript(indexPath: IndexPath) -> T {
        items[indexPath.row]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        clearSelection()
    }

    func clearSelection() {

    }

    @objc
    func reloadItems() {

    }

    func reloadView() {
    }

}

extension UITableView {

    func dequeueReusableCell<T: Item>(for item: T, for indexPath: IndexPath) -> TableItemCell<T> {
        let cell = dequeueReusableCell(withIdentifier: (item as Item).cellIdentifier ?? "Cell",
                                       for: indexPath) as! TableItemCell<T>
        cell.item = item
        return cell
    }

}
