//
//  CollectionItemsController.swift
//  Heap
//
//  Created by Alex Kozin on 03/07/2019.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

class CollectionItemsController<T: Item>: ItemsController<T>, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!

    var layout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }

    override func reloadView() {
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        let identifier = item.cellIdentifier ?? "Cell"

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                      for: indexPath) as! CollectionItemCell<T>
        cell.item = item

        return cell
    }

}
