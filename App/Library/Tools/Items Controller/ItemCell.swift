//
//  TableItemCell.swift
//  Heap
//
//  Created by Alex Kozin.
//  Copyright (c) 2013 General Rhetoric Ltd. All rights reserved.
//

import UIKit

protocol ItemCell  {
    associatedtype T

    var item: T? {get set}
    func showItem()

}

class TableItemCell<T>: UITableViewCell, ItemCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        prepare()
    }

    func prepare() {

    }

    var item: T? {
        didSet {
            showItem()
        }
    }

    func showItem() {
    }

}

class IdItemCell: TableItemCell<IdItem> {

}

class CollectionItemCell<T>: UICollectionViewCell, ItemCell {

    var item: T? {
        didSet {
            showItem()
        }
    }

    func showItem() {
    }

}

