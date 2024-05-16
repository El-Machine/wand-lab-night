//
//  TableView+Utils.swift
//  Heap
//
//  Created by Alex Kozin on 02.06.2020.
11(
//

import UIKit

extension UITableView {

    func setHeader(height: CGFloat) {
        let header = tableHeaderView ?? UIView()

        var frame = header.frame
        frame.size.height = height

        tableHeaderView = nil
        header.frame = frame
        tableHeaderView = header
    }

    func setFooter(height: CGFloat) {
        let footer = tableFooterView ?? UIView()
        var frame = footer.frame
        frame.size.height = height

        tableFooterView = nil
        footer.frame = frame
        tableFooterView = footer
    }

}
