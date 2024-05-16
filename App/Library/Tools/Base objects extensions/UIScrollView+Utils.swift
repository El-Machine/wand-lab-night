//
//  UIScrollView+Utils.swift
//  Heap
//
//  Created by Alex Kozin on 31.05.16.
//  Copyright © 2020 El Machine. All rights reserved.
//

import UIKit

extension UIScrollView {

    var progress: CGFloat {
        contentOffset.y / maxContentOffset().y 
    }

    func scrollToTop(animated: Bool) {
        setContentOffset((-contentInset.top)|, animated: animated)
    }

    func maxContentOffset() -> CGPoint {
        let size = frame.size;

        let contentWidth = contentSize.width
        let contentHeight = contentSize.height

        let i = contentInset
        let s = safeAreaInsets

        let maxOffsetX = contentWidth < size.width ? 0.0 : contentWidth - size.width;
        let maxOffsetY = contentHeight < size.height ? 0.0 : contentHeight - size.height;

        return CGPoint(x: maxOffsetX + i.left + i.right + s.left + s.right,
                       y: maxOffsetY + i.top + i.bottom + s.top + s.bottom);
    }

    func scrollToBottom(animated: Bool) {
        setContentOffset(maxContentOffset(), animated: true)
    }

}
