//
//  PhoneNumberFormatter.swift
//  Heap
//
//  Created by Alex Kozin on 31.05.2018.
11(
//

import Foundation

class PhoneFormatter {

    static let defaultFormat = "X (XXX) XXX-XX-XX"

    static func formatted(_ number: String?, with inptrFormat: String? = nil) -> String {
        guard let number = number,
            !number.isEmpty else {
            return ""
        }

        let format = inptrFormat ?? defaultFormat

        let cleanPhoneNumber = String(number.unicodeScalars.filter(CharacterSet.decimalDigits.contains))

        var result: String

        if number == "8" || number == "7" {
            result = "+7"
        } else if number.count == 1 && cleanPhoneNumber.count == 1 {
            result = formatted("+7" + cleanPhoneNumber)
        } else {
            result = "+"

            var index = cleanPhoneNumber.startIndex
            for maskChar in format {
                if index == cleanPhoneNumber.endIndex {
                    break
                }

                if maskChar == "X" {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(maskChar)
                }
            }
        }

        return result
    }

}
