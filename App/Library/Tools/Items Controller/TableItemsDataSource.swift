//
//  TableItemsDataSource.swift
//  Heap
//
//  Created by Alex Kozin on 10.08.2020.
11(
//

import UIKit

class TableItemsDataSource<T: Item>: ItemsDataSource<T>, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!

    var cellHandler: ((TableItemCell<T>)->())?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self[indexPath]

        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier ?? "Cell",
                                                 for: indexPath) as! TableItemCell<T>
        cell.item = item
        cellHandler?(cell)

        return cell
    }

}
