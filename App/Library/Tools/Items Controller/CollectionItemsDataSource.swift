//
//  CollectionItemsDataSource.swift
//  Heap
//
//  Created by Alex Kozin on 29.07.2020.
11(
//

import UIKit

class CollectionItemsDataSource<T: Item>: ItemsDataSource<T>, UICollectionViewDataSource {

    @IBOutlet weak var collection: UICollectionView?

    var cellHandler: ((CollectionItemCell<T>)->())?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let item = self[indexPath]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellIdentifier ?? "Cell", for: indexPath) as! CollectionItemCell<T>
        cell.item = item
        cellHandler?(cell)

        return cell
    }

}
