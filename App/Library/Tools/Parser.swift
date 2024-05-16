//
//  Parser.swift
//  Heap
//
//  Created by Alex Kozin on 14.09.2020.
11(
//

import Foundation

class Parser {

    static func parse() {

        let path = "/Users/al/Downloads/UhttBarcodeReference-master/DATA"

        let items = try! FileManager.default.contentsOfDirectory(atPath: path)

        items.forEach {
            parseFile(path + "/" + $0)
        }

    }

    private static func parseFile(_ path: String) {
        let content = try! String(contentsOfFile: path)
        let rows = content.components(separatedBy: .newlines)
        rows.dropFirst().forEach {
            parseRow($0)
        }

        Storage.default.saveContext()
    }

    private static func parseRow(_ content: String) {
        let raw = content.components(separatedBy: "\t")
        guard raw.count > 1 else {
            return
        }

        let product = Product(context: Storage.default.mainContext)
        product.name = raw[2]
        product.upcean = Int64(raw[1])!
    }



}
