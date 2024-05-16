//
//  Pipe.swift
//  Heap
//
//  Created by Alex Kozin on 29.09.2020.
11(
//

struct Box<T: Pipable>: Pipable {
    
//    static func | (p: Pipable, handler: (T?) -> ()) -> Pipable {
//
//    }
    
}

extension Bool: Pipable {

    static postfix func | (p: Bool) -> CGFloat {
        p ? 1 : 0
    }

}

import CoreLocation.CLLocation

postfix func |(p: (CLLocationDegrees, CLLocationDegrees)) -> CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: p.0, longitude: p.1)
}

extension Int: Pipable {

    static postfix func |(p: Self) -> IndexSet {
        IndexSet(0...p)
    }
    
    static postfix func |(p: Self) -> IndexPath {
        IndexPath(row: p, section: 0)
    }
    
    static postfix func |(p: Self) -> [IndexPath] {
        [p|]
    }
    
    static postfix func |(p: Self) -> UIView {
        UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat(p)))
    }

}
