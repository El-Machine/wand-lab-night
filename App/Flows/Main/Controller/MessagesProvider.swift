//
//  MessagesProvider.swift
//  Psycho
//
//  Created by Alex Kozin on 29.10.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import Foundation
import UIKit

protocol MessagesProviderDelegate: AnyObject {

    func received(messages: [Message])

    func typingStateChanged(to state: TypingState)

    func lastReadIdChanged(to id: String)

    func lastReceivedIdChanged(to id: String)

}

final class MessagesProvider {

    weak var delegate: MessagesProviderDelegate?

    private var messageTimer: Timer?

    private var typingTimer: Timer?

    private var startingTimestamp = Date().timeIntervalSince1970

    private var typingState: TypingState = .idle

    private var lastMessageIndex: Int = 0

    private let dispatchQueue = DispatchQueue.global(qos: .userInteractive)

    private let enableTyping = true

    private let enableNewMessages = true

    private let enableRichContent = true

    private let websiteUrls: [URL] = [
        URL(string: "https://messagekit.github.io")!,
        URL(string: "https://www.youtube.com/watch?v=GEZhD3J89ZE"),
        URL(string: "https://www.raywenderlich.com/7565482-visually-rich-links-tutorial-for-ios-image-thumbnails"),
        URL(string: "https://github.com/ekazaev/route-composer"),
        URL(string: "https://www.youtube.com/watch?v=-rAeqN-Q7x4"),
        URL(string: "https://en.wikipedia.org/wiki/Dublin"),
        URL(string: "https://en.wikipedia.org/wiki/Republic_of_Ireland"),
        URL(string: "https://en.wikipedia.org/wiki/Cork_(city)"),
        URL(string: "https://github.com/ekazaev/ChatLayout"),
        URL(string: "https://websummit.com")
    ].compactMap { $0 }

    private let imageUrls: [URL] = [
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/a/a4/General_Post_Office_Dublin_20060803.jpg")!,
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/O%27Connell_Street_Dublin_%26_Jim_Larkin.JPG/800px-O%27Connell_Street_Dublin_%26_Jim_Larkin.JPG")!,
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/St.Patrick%27s_Bridge.jpg/2560px-St.Patrick%27s_Bridge.jpg")!,
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/9/97/Fountain_Galway_01.jpg")!,
        URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Limerick-King-Johns-Castle-2012.JPG/1920px-Limerick-King-Johns-Castle-2012.JPG")!
    ]

    private let images: [UIImage] = (1...8).compactMap { UIImage(named: "demo\($0)") }

    func loadInitialMessages(completion: @escaping ([Message]) -> Void) {
        dispatchQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            let messages = self.createBunchOfMessages(number: 50)
            DispatchQueue.main.async {
                completion(messages)
            }
        }
    }

    func loadPreviousMessages(completion: @escaping ([Message]) -> Void) {
        dispatchQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            let messages = self.createBunchOfMessages(number: 50)

            DispatchQueue.main.async {
                completion(messages)
            }
        }
    }

//    private func createRandomMessage(date: Date = Date()) -> Message {
////        Message(id: "", date: date, data: .text(TextGenerator.getString(of: 20)), owner: User(id: 0), type: .incoming)
//////        let sender = allUsersIds[Int.random(in: 0..<allUsersIds.count)]
//////        lastMessageIndex += 1
//////        switch (Int.random(in: 0...8), enableRichContent) {
//////        case (6, true):
//////            return Message(id: String(), date: date, data: .url(websiteUrls[Int.random(in: 0..<websiteUrls.count)]), userId: sender)
//////        case (5, true):
//////            return Message(id: String(), date: date, data: .image(.imageURL(imageUrls[Int.random(in: 0..<imageUrls.count)])), userId: sender)
//////        case (7, true):
//////            return Message(id: String(), date: date, data: .image(.image(images[Int.random(in: 0..<images.count)])), userId: sender)
//////        default:
//////            return Message(id: String(), date: date, data: .text(TextGenerator.getString(of: 20)), userId: sender)
//////        }
//    }

    private func createBunchOfMessages(number: Int = 50) -> [Message] {
//        let messages = (0..<number).map { _ -> Message in
//            startingTimestamp -= TimeInterval(Int.random(in: 100...1000))
//            return self.createRandomMessage(date: Date(timeIntervalSince1970: startingTimestamp))
//        }
        return [Message]()
    }

}
