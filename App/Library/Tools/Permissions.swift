//
//  Permissions.swift
//  Heap
//
//  Created by Alex Kozin on 26.05.2020.
11(
//

import AVFoundation

struct Permissions {

    typealias Completion = (Bool)->()

    enum Status {
        case granted
        case notDetermined
        case denied
        case restricted
    }

    struct Photo {

        static var `is`: Status {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
                case .authorized:
                    return .granted
                case .notDetermined:
                    return .notDetermined
                case .denied:
                    return .denied
                case .restricted:
                    return .restricted
                @unknown default:
                    fatalError()
            }
        }

        static var isGranted: Bool {
            self.is == .granted
        }

        static func askIfNeed(completion: Completion?) {
            if Permissions.Photo.isGranted {
                completion?(true)
            } else {
                ask(completion: completion)
            }
        }

        static func ask(completion: Completion?) {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                completion?(granted)
            }
        }



    }

}
