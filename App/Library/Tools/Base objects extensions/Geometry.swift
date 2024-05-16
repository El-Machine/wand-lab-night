//
//  CoreGraphicsUtils.swift
//  Heap
//
//  Created by Alex Kozin on 17.04.2020.
11(
//

import CoreGraphics
import CoreLocation
import UIKit.UIGeometry

extension CGSize {

    init(_ dimension: CGFloat) {
        self.init(width: dimension, height: dimension)
    }

    var ratio: CGFloat {
         height / width
    }

}

extension CGRect {

    init(_ size: CGSize) {
        self.init(origin: .zero, size: size)
    }

    init(_ dimension: CGFloat) {
        self.init(x: 0, y: 0, width: dimension, height: dimension)
    }

    init(width: CGFloat, height: CGFloat) {
        self.init(x: 0, y: 0, width: width, height: height)
    }

    init(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.init(x: x ?? 0, y: y ?? 0, width: width ?? 0, height: height ?? 0)
    }
    

}

extension FloatingPoint {

    func project(_ velocity: Self, deceleration: Self) -> Self {
        if deceleration >= 1 {
            assert(false)
            return self
        }
        return self + velocity * deceleration / (1 - deceleration)
    }

    func nearest(to anchors: [Self]) -> Self {
        anchors.min(by: {abs($0 - self) < abs($1 - self)})!
    }

}

extension CGPoint {

    func project(_ velocity: CGPoint, deceleration: CGPoint) -> CGPoint {
        CGPoint(
            x: x.project(velocity.x, deceleration: deceleration.x),
            y: y.project(velocity.y, deceleration: deceleration.y)
        )
    }

    func project(_ velocity: CGPoint, deceleration: CGFloat) -> CGPoint {
        project(velocity, deceleration: CGPoint(x: deceleration, y: deceleration))
    }

}

extension UIEdgeInsets {

    init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0) {
        self.init(top: top, left: left, bottom: bottom, right: 0)
    }

}



extension Range where Bound == Int {


    func inBox() -> [IndexPath] {
        map {
            IndexPath(row: $0, section: 0)
        }
    }

}

extension Array {

    func inBox() -> Range<Int> {
        0..<count
    }

    func inBox() -> [IndexPath] {
        (0..<count).inBox()
    }

}

extension IndexPath {

    var prev: IndexPath? {
        let prev = row - 1
        guard prev >= 0 else {
            return nil
        }

        return IndexPath(row: prev, section: section)
    }

    var next: Self {
        IndexPath(row: row + 1, section: section)
    }


}
extension Array {

    @discardableResult
    mutating func removeFirst(where shouldBeRemoved: (Element) -> Bool) -> Element? {
        guard let i = firstIndex(where: shouldBeRemoved) else {
            return nil
        }

        return remove(at: i)
    }

    mutating func insert(_ newElement: Element?, at i: Int) {
        guard let element = newElement else {
            return
        }

        insert(element, at: i)
    }

    mutating func append(_ newElement: Element?) {
        guard let element = newElement else {
            return
        }

        append(element)
    }

//protocol Trasformer {
//
//    associatedtype Transformed
//
//    var t: Transformed {get}
//
//}
//
//extension CGFloat: Trasformer {
//
//    var t: UIEdgeInsets {
//        UIEdgeInsets(top: self, left: self, bottom: self, right: self)
//    }
//
//}
//
//extension CGFloat: Trasformer {
//
//    typealias Transformed = CGSize
//
//    var t: CGSize {
//        CGSize(width: self, height: self)
//    }
//
//}

}
