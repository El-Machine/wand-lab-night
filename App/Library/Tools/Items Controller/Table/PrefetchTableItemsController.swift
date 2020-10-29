//
//  PrefetchTableItemsController.swift
//  Heap
//
//  Created by Alex Kozin on 27/05/2019.
//  Copyright © 2019 Alex Kozin. All rights reserved.
//

import UIKit

class PrefetchItemsTableController<T: Item>: TableItemsController<T> {

    let prefetchDistance = 5

    func requestNextPage() {

    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        super.tableView(tableView, willDisplay: cell, forRowAt: indexPath)
        
        if indexPath.row > items.count - prefetchDistance {
            requestNextPage()
        }
    }

}
