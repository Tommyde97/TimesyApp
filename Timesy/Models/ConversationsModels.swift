//
//  ConversationsModels.swift
//  Timesy
//
//  Created by Tomas D. De Andrade Gomes on 7/17/23.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
