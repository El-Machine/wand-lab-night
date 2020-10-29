//
//  ImagePicker.swift
//  Heap
//
//  Created by Alex Kozin on 04.03.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import CoreServices
import UIKit

class ImagePicker: NSObject {

    typealias Presenting = () -> ()
    typealias Completion = (UIImage?) -> ()
    typealias `Type` = UIImagePickerController.SourceType

    var completion: Completion!
    lazy var picker: UIImagePickerController = {
        let p = UIImagePickerController()
        p.allowsEditing = false
        p.delegate = self
        p.mediaTypes = [kUTTypeImage as String]

        return p
    }()

    var strongRef: ImagePicker?

    static func `is`(available type: Type) -> Bool {
        UIImagePickerController.isSourceTypeAvailable(type)
    }

    func pick(from source: Type = .photoLibrary,
              on viewController: UIViewController? = nil,
              presenting: Presenting? = nil,
              completion: @escaping Completion) {

        self.completion = completion

        let picker = self.picker
        picker.sourceType = source

        let target = viewController ?? UIApplication.shared.visibleViewController
        target?.present(picker, completion: presenting)

        strongRef = self
    }

    func dismiss() {
        picker.dismiss()

        strongRef = nil
    }

}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        completion(image)
        dismiss()
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        completion(nil)
        dismiss()
    }

}
