//
//  Email.swift
//  VMail
//
//  Created by Sarvesh Suryavanshi on 03/12/21.
//

import RealmSwift

// MARK: - Email
class Email: Object, Codable {
    @objc dynamic var senderName, senderEmailID, subject, body, profileImage, time, attachmentName: String
    @objc dynamic var type: String
    @objc dynamic var cc: String
    @objc dynamic var hasAttachment: Bool
    @objc dynamic var date: Date
    @objc dynamic var isMarked, isFavourite: Bool
}

enum Type: String, Codable {
case P // Promotion
case S // Social
}

typealias Emails = [Email]
