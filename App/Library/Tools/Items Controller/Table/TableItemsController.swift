//
//  Table.swiftItemsController.swift
//  Heap
//
//  Created by Alex Kozin on 03/07/2019.
//  Copyright © 2019 Alex Kozin. All rights reserved.
//

import UIKit

class TableItemsController<T: Item>: ItemsController<T>, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView?

    override func clearSelection() {
        tableView?.selectRow(at: nil, animated: true, scrollPosition: .none)
    }

    override func reloadView() {
        tableView?.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: self[indexPath].cellIdentifier ?? "Cell",
                                      for: indexPath)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! TableItemCell<T>).item = self[indexPath]
    }

    //All items are same height, using rowHeight in IB instead
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self[indexPath].height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }

}
