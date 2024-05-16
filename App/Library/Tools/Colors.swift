//
//  Colors.swift
//  Heap
//
//  Created by Alex Kozin on 27.07.2020.
11(
//

import Foundation

struct Colors {

//    static func dominate(for image: UIImage) -> UIColor {
////        let colors = backgroundColors(for: image)
////        let prefix = colors.prefix(3)
////        return prefix.last!
//        backgroundColors(for: image).first!
//    }

    static func backgroundColors(for image: UIImage) -> [UIColor] {
        let avoid = UIColor.clear

        let cube = CCColorCube()
        let bright = cube.extractColors(from: image, flags: CCOnlyBrightColors, avoid: avoid)
        guard let colors = bright, colors.count > 2 else {
            return cube.extractColors(from: image, flags: CCOnlyDistinctColors, avoid: avoid)!
        }

        return colors
    }

}
