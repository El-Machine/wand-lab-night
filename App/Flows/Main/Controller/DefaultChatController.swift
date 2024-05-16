//
// ChatLayout
// DefaultChatController.swift
// https://github.com/ekazaev/ChatLayout
//
// Created by Eugene Kazaev in 2020.
// Distributed under the MIT license.
//

import ChatLayout
import Foundation

final class DefaultChatController: ChatController {

    weak var delegate: ChatControllerDelegate?

    private let dataProvider: MessagesProvider

    private var typingState: TypingState = .idle

    private let dispatchQueue = DispatchQueue(label: "DefaultChatController", qos: .userInteractive)

    private var lastReadUUID: String?

    private var lastReceivedUUID: String?

    private let userId: Int

    var messages: [Message] = []

    init(dataProvider: MessagesProvider, userId: Int) {
        self.dataProvider = dataProvider
        self.userId = userId
    }

    func loadInitialMessages(completion: @escaping ([Section]) -> Void) {
        dataProvider.loadInitialMessages { messages in
            self.appendConvertingToMessages(messages)
            self.markAllMessagesAsReceived {
                self.markAllMessagesAsRead {
                    self.propagateLatestMessages { sections in
                        completion(sections)
                    }
                }
            }
        }
    }

    func loadPreviousMessages(completion: @escaping ([Section]) -> Void) {
        dataProvider.loadPreviousMessages(completion: { messages in
            self.appendConvertingToMessages(messages)
            self.markAllMessagesAsReceived {
                self.markAllMessagesAsRead {
                    self.propagateLatestMessages { sections in
                        completion(sections)
                    }
                }
            }
        })
    }

    func sendMessage(_ text: String, completion: @escaping ([Section]) -> Void) {
        let message = Message()
        message.createRecordIfNeed()
        message.text = text
        messages.append(message)
        
        propagateLatestMessages { sections in
            completion(sections)
        }
    }

    private func appendConvertingToMessages(_ Messages: [Message]) {
        var messages = self.messages
        messages.append(contentsOf: Messages)
        self.messages = messages.sorted(by: { $0.creationDate.timeIntervalSince1970 < $1.creationDate.timeIntervalSince1970 })
    }

    private func propagateLatestMessages(completion: @escaping ([Section]) -> Void) {
        var lastMessageStorage: Message?
        dispatchQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            let messagesSplitByDay = self.messages
                .map { Message(id: $0.id, date: $0.date, data: $0.data, owner: User(id: 0), type: 1 == self.userId ? .outgoing : .incoming, status: $0.status) }
                .reduce(into: [[Message]]()) { result, message in
                    guard var section = result.last,
                        let prevMessage = section.last else {
                        let section = [message]
                        result.append(section)
                        return
                    }
                    if Calendar.current.isDate(prevMessage.date, equalTo: message.date, toGranularity: .hour) {
                        section.append(message)
                        result[result.count - 1] = section
                    } else {
                        let section = [message]
                        result.append(section)
                    }
                }

            let cells = messagesSplitByDay.enumerated().map { index, messages -> [Cell] in
                var cells: [Cell] = Array(messages.enumerated().map { index, message -> [Cell] in
                    let bubble: Cell.BubbleType
                    if index < messages.count - 1 {
                        let nextMessage = messages[index + 1]
                        bubble = nextMessage.owner == message.owner ? .normal : .tailed
                    } else {
                        bubble = .tailed
                    }
                    guard message.type != .outgoing else {
                        lastMessageStorage = message
                        return [.message(message, bubbleType: bubble)]
                    }

                    let titleCell = Cell.messageGroup(MessageGroup(id: message.id, title: "\(message.owner.name)", type: message.type))

                    if let lastMessage = lastMessageStorage {
                        if lastMessage.owner != message.owner {
                            lastMessageStorage = message
                            return [titleCell, .message(message, bubbleType: bubble)]
                        } else {
                            lastMessageStorage = message
                            return [.message(message, bubbleType: bubble)]
                        }
                    } else {
                        lastMessageStorage = message
                        return [titleCell, .message(message, bubbleType: bubble)]
                    }
                }.joined())

                if let firstMessage = messages.first {
                    let dateCell = Cell.date(DateGroup(id: firstMessage.id, date: firstMessage.date))
                    cells.insert(dateCell, at: 0)
                }

                if self.typingState == .typing,
                    index == messagesSplitByDay.count - 1 {
                    cells.append(.typingIndicator)
                }

                return cells // Section(id: sectionTitle.hashValue, title: sectionTitle, cells: cells)
            }.joined()

            DispatchQueue.main.async { [weak self] in
                guard self != nil else {
                    return
                }
                completion([Section(id: 0, title: "Loading...", cells: Array(cells))])
            }
        }

    }

}

extension DefaultChatController: MessagesProviderDelegate {

    func received(messages: [Message]) {
        appendConvertingToMessages(messages)
        markAllMessagesAsReceived {
            self.markAllMessagesAsRead {
                self.propagateLatestMessages { sections in
                    self.delegate?.update(with: sections)
                }
            }
        }
    }

    func typingStateChanged(to state: TypingState) {
        typingState = state
        propagateLatestMessages { sections in
            self.delegate?.update(with: sections)
        }
    }

    func lastReadIdChanged(to id: String) {
        lastReadUUID = id
        markAllMessagesAsRead {
            self.propagateLatestMessages { sections in
                self.delegate?.update(with: sections)
            }
        }
    }

    func lastReceivedIdChanged(to id: String) {
        lastReceivedUUID = id
        markAllMessagesAsReceived {
            self.propagateLatestMessages { sections in
                self.delegate?.update(with: sections)
            }
        }
    }

    func markAllMessagesAsReceived(completion: @escaping () -> Void) {
        guard let lastReceivedUUID = lastReceivedUUID else {
            completion()
            return
        }
        dispatchQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            var finished = false
            self.messages = self.messages.map { message in
                guard !finished, message.status != .received, message.status != .read else {
                    if message.id == lastReceivedUUID {
                        finished = true
                    }
                    return message
                }
                var message = message
                message.status = .received
                if message.id == lastReceivedUUID {
                    finished = true
                }
                return message
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func markAllMessagesAsRead(completion: @escaping () -> Void) {
        guard let lastReadUUID = lastReadUUID else {
            completion()
            return
        }
        dispatchQueue.async { [weak self] in
            guard let self = self else {
                return
            }
            var finished = false
            self.messages = self.messages.map { message in
                guard !finished, message.status != .read else {
                    if message.id == lastReadUUID {
                        finished = true
                    }
                    return message
                }
                var message = message
                message.status = .read
                if message.id == lastReadUUID {
                    finished = true
                }
                return message
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }

}

extension DefaultChatController: ReloadDelegate {

    func reloadMessage(with id: String) {
        propagateLatestMessages(completion: { sections in
            self.delegate?.update(with: sections)
        })
    }

}

extension DefaultChatController: EditingAccessoryControllerDelegate {

    func deleteMessage(with id: String) {
        messages = Array(messages.filter { $0.recordName != id })
        propagateLatestMessages(completion: { sections in
            self.delegate?.update(with: sections)
        })
    }

}
