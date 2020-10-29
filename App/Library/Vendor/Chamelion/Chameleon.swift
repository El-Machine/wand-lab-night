//
//  Chameleon.swift
//  Heap
//
//  Created by Alex Kozin on 27.07.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import Foundation

struct Chameleon {

    static func triadicColorScheme(using color: UIColor, flat: Bool) -> [UIColor] {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0

        //Extract HSB values from input color
        color.getHue(&h, saturation: &s, brightness: &b, alpha: nil)

        //Multiply our values by the max value to convert
        h *= 360
        s *= 100
        b *= 100

        var first = UIColor(hue: add(120, to: h),
                            saturation: (7*s/6)/100,
                            brightness: (b-5)/100,
                            alpha: 1.0)

        var second = UIColor(hue: add(120, to: h)/360,
                             saturation: s/100,
                             brightness: (b+9)/100,
                             alpha: 1.0)

        var third = UIColor(hue: h/360,
                            saturation: s/100,
                            brightness: b/100,
                            alpha: 1.0)

        var fourth = UIColor(hue: add(240, to: h)/360,
                             saturation: (7*s/6)/100,
                             brightness: (b-5)/100,
                             alpha: 1.0)

        var fifth = UIColor(hue: add(240, to: h)/360,
                            saturation: s/100,
                            brightness: (b-30)/100,
                            alpha: 1.0)

        if (flat) {
            //Flatten colors
            first = first.flatten()
            second = second.flatten()
            third = third.flatten()
            fourth = fourth.flatten()
            fifth = fifth.flatten()

            //Make sure returned colors are unique

            //Inner Colors
            if second == third {
                second = second.darken(byPercentage: 0.25)!.flatten()
            }

            if third == fourth {
                fourth = fourth.darken(byPercentage: 0.25)!.flatten()
            }

            if first == third {
                first = first.darken(byPercentage: 0.25)!.flatten()
            }

            if fifth == third {
                fifth = fifth.darken(byPercentage: 0.25)!.flatten()
            }

            //Outer Colors
            if first == second {
                first = first.darken(byPercentage: 0.25)!.flatten()
            }

            if fourth == fifth {
                fifth = fifth.darken(byPercentage: 0.25)!.flatten()
            }

        }

        return [first, second, third, fourth, fifth]
    }

    private static func add(_ newValue: CGFloat, to: CGFloat) -> CGFloat {
        let currentValue = to + newValue

        //Check if currentValue exceeds 360 degrees
        if (currentValue > 360) {
            return currentValue - 360;
        }

        else if (currentValue < 0) {
            return -1 * currentValue;
        }

        else {
            return currentValue;
        }
    }

}
