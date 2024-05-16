//
// ChatLayout
// Message.swift
// https://github.com/ekazaev/ChatLayout
//
// Created by Eugene Kazaev in 2020.
// Distributed under the MIT license.
//

import ChatLayout
import DifferenceKit

import CloudKit

enum MessageType: Int {

    case incoming

    case outgoing

    var isIncoming: Bool {
        return self == .incoming
    }

}

enum MessageStatus: Hashable {

    case sent

    case received

    case read

}

extension ChatItemAlignment {

    var isIncoming: Bool {
        return self == .leading
    }

}

struct DateGroup: Hashable {

    var id: String

    var date: Date

    var value: String {
        return ChatDateFormatter.shared.string(from: date)
    }

    init(id: String, date: Date) {
        self.id = id
        self.date = date
    }

}

extension DateGroup: Differentiable {

    public var differenceIdentifier: Int {
        return hashValue
    }

    public func isContentEqual(to source: DateGroup) -> Bool {
        self == source
    }

}

struct MessageGroup: Hashable {

    var id: String

    var title: String

    var type: MessageType

    init(id: String, title: String, type: MessageType) {
        self.id = id
        self.title = title
        self.type = type
    }

}

extension MessageGroup: Differentiable {

    public var differenceIdentifier: Int {
        return hashValue
    }

    public func isContentEqual(to source: MessageGroup) -> Bool {
        self == source
    }

}

class Message: BaseModel {

    var type = MessageType.incoming
    var status: MessageStatus = .sent
    
    var text: String? {
        get {
            record?["text"]
        }
        set {
            record?["text"] = newValue
        }
    }

}

extension Message: Differentiable {

    public var differenceIdentifier: Int {
        recordName.hashValue
    }

    public func isContentEqual(to source: Message) -> Bool {
        return self == source
    }

}
