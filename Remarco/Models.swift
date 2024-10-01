//
//  Models.swift
//  Remarco
//
//  Created by Nikolay Khort on 05.01.2024.
//

// Models.swift

import Foundation

class MeetingNote: Identifiable, ObservableObject {
    var id = UUID()
    @Published var date: Date
    @Published var name: String
    @Published var summary: String
    @Published var notes: String
    @Published var reminders: [Reminder]
    @Published var attachments: [Attachment]
    @Published var peerID: UUID

    init(date: Date, name: String, summary: String, notes: String, reminders: [Reminder], attachments: [Attachment], peerID: UUID) {
        self.date = date
        self.name = name
        self.summary = summary
        self.notes = notes
        self.reminders = reminders
        self.attachments = attachments
        self.peerID = peerID
    }
}

class Reminder: Identifiable, Equatable, Hashable {
    static func == (lhs: Reminder, rhs: Reminder) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id = UUID()
    var title: String
    var isComplete: Bool
    var meetingNoteID: UUID
    var peerID: UUID

    init(title: String, isComplete: Bool, meetingNoteID: UUID, peerID: UUID) {
        self.title = title
        self.isComplete = isComplete
        self.meetingNoteID = meetingNoteID
        self.peerID = peerID
    }
}


struct Attachment: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
}

