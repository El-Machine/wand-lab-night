//
//  Image+Utils.swift
//  Heap
//
//  Created by Alex Kozin on 20.04.2020.
11(
//

import AVFoundation
import UIKit

extension UIImage {

    func scaled(to dimension: CGFloat) -> UIImage {
        scaled(to: CGSize(dimension), scale: 1)
    }

    func scaledWidth(to width: CGFloat = UIScreen.main.bounds.width) -> UIImage {
        scaled(to: CGSize(width: width, height: .greatestFiniteMagnitude))
    }

    func scaled(to targetSize: CGSize, scale: CGFloat? = nil) -> UIImage {
        let maxRect = CGRect(targetSize)
        guard !maxRect.contains(CGRect(size)) else {
            return self
        }

        let scaled = AVMakeRect(aspectRatio: self.size, insideRect: maxRect).size

        let format = UIGraphicsImageRendererFormat.default()
        if let scale = scale {
            format.scale = scale
        }
        let rendrer = UIGraphicsImageRenderer(size: scaled, format: format)
        let newImage = rendrer.image { c in
            self.draw(in: CGRect(scaled))
        }

        return newImage
    }

    func rounded(to radius: CGFloat = 20) -> UIImage {
        let format = imageRendererFormat
        format.opaque = false
        let image = UIGraphicsImageRenderer(size: size, format: format).image { _ in
            UIBezierPath(roundedRect: CGRect(size), cornerRadius: radius).addClip()
            self.draw(at: .zero)
        }

        return image
    }

    func scaledAndRounded() -> UIImage {
        let maxRect = CGRect(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        guard !maxRect.contains(CGRect(size)) else {
            return self
        }

        let format = imageRendererFormat
        format.opaque = false

        let scaled = AVMakeRect(aspectRatio: self.size, insideRect: maxRect).size
        let rendrer = UIGraphicsImageRenderer(size: scaled, format: format)
        let newImage = rendrer.image { c in
            UIBezierPath(roundedRect: CGRect(scaled), cornerRadius: 20).addClip()
            self.draw(in: CGRect(scaled))
        }

        return newImage
    }

    func toUpload() -> UIImage {
        let screen = UIScreen.main.bounds.size

        var x: CGFloat

        var width: CGFloat
        var height: CGFloat

        let screenScaleK = size.height / screen.height //Resize to visible on screen

        if size.height > size.width {
            height = 2732

            let resizeK = height / size.height
            width = (size.width - ((size.width/screenScaleK - screen.width) * screenScaleK)) * resizeK
            width = floor(width)

            x = (size.width * resizeK - width) / 2
        } else {
            width = 1242
            height = size.height * width / size.width

            x = 0
        }

        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1

        let uploadSize = CGSize(width: width, height: height)
        let rendrer = UIGraphicsImageRenderer(size: uploadSize, format: format)
        let newImage = rendrer.image { c in
            self.draw(in: CGRect(x: -x, width: width + x * 2, height: height))
        }

        return newImage
    }

    func heic(with quality: CGFloat = 0.95) -> Data? {
        let data = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(data, AVFileType.heic as CFString, 1, nil) else {
            return nil
        }

        let options = [kCGImageDestinationLossyCompressionQuality: quality] as CFDictionary
        CGImageDestinationAddImage(destination, cgImage!, options)
        guard CGImageDestinationFinalize(destination) else {
            return nil
        }

        return data as Data
    }

    func data(with quality: CGFloat = 0.95) -> Data {
        var data = heic(with: quality)
        if data == nil {
            data = jpegData(compressionQuality: quality)
        }

        return data!
    }

    func height(for width: CGFloat) -> CGFloat {
        let maxRect = CGRect(CGSize(width: width, height: .greatestFiniteMagnitude))
        return AVMakeRect(aspectRatio: self.size, insideRect: maxRect).height
    }

    var isHorizontal: Bool {
        size.width > size.height
    }

}
