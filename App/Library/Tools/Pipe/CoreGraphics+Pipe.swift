//
//  CoreGraphics+Pipe.swift
//  Run
//
//  Created by Alex Kozin on 04.10.2020.
11(
//

import CoreGraphics

extension CGFloat: Pipable {
    
    static postfix func |(p: Self) -> UIEdgeInsets {
        p|.bottom
    }
    
    static postfix func |(p: Self) -> (top: UIEdgeInsets,
                                       left: UIEdgeInsets,
                                       bottom: UIEdgeInsets,
                                       right: UIEdgeInsets) {
        (UIEdgeInsets(top: p, left: 0, bottom: 0, right: 0),
         UIEdgeInsets(top: 0, left: p, bottom: 0, right: 0),
         UIEdgeInsets(top: 0, left: 0, bottom: p, right: 0),
         UIEdgeInsets(top: 0, left: 0, bottom: 0, right: p))
    }
    
    static postfix func |(p: Self) -> CGPoint {
        p|.y
    }
    
    static postfix func |(p: Self) -> (x: CGPoint, y: CGPoint) {
        (CGPoint(x: p, y: 0), CGPoint(x: 0, y: p))
    }
    
}

extension CGRect {
    
    static postfix func |(p: Self) -> UIView {
        UIView(frame: p)
    }
    
}

postfix func |(p: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) -> CGRect {
    CGRect(x: p.0, y: p.1, width: p.2, height: p.3)
}

postfix func |(p: (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat)) -> UIView {
    UIView(frame: CGRect(x: p.0, y: p.1, width: p.2, height: p.3))
}

postfix func |(p: (x: CGFloat, y: CGFloat)) -> CGPoint {
    CGPoint(x: p.0, y: p.1)
}

postfix func |(p: (width: CGFloat, height: CGFloat)) -> CGSize {
    CGSize(width: p.0, height: p.1)
}

postfix func |(p: (CGFloat, CGFloat, CGFloat, CGFloat)) -> UIEdgeInsets {
    UIEdgeInsets(top: p.0, left: p.1, bottom: p.2, right: p.3)
}
