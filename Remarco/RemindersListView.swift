//
//  RemindersListView.swift
//  Remarco
//
//  Created by Nikolay Khort on 08.01.2024.
//

import SwiftUI

struct RemindersListView: View {
    
    @State private var reminders: [Reminder] = [
        Reminder(title: "Reminder 1", isComplete: false, meetingNoteID: UUID(), peerID: UUID()),
        Reminder(title: "Reminder 2", isComplete: true, meetingNoteID: UUID(), peerID: UUID()),
        Reminder(title: "Reminder 3", isComplete: false, meetingNoteID: UUID(), peerID: UUID()),
        Reminder(title: "Reminder 4", isComplete: false, meetingNoteID: UUID(), peerID: UUID()),
        Reminder(title: "Reminder 5", isComplete: false, meetingNoteID: UUID(), peerID: UUID())
        // Add more reminders as needed
    ]

    var body: some View {
        VStack {
            Text("Reminders List")
                .font(.title)

            List {
                ForEach(reminders, id: \.id) { reminder in
                    HStack {
                        Toggle("", isOn: $reminders[reminders.firstIndex(of: reminder)!].isComplete)
                            .labelsHidden()
                            .toggleStyle(CheckboxStyle())
                        Text(reminder.title)
                        Spacer()
                        Image(systemName: "line.3.horizontal").padding(.trailing)
                    }
                    .padding(.vertical, 5)
                }
                .onMove { indices, newOffset in
                    reminders.move(fromOffsets: indices, toOffset: newOffset)
                }
                .listRowBackground(ColorScheme.lightBackgroundColor)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Reminders")
        .background(ColorScheme.lightBackgroundColor)
    }
}

struct RemindersListView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersListView()
    }
}

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .imageScale(.large)
                .foregroundColor(configuration.isOn ? .green : .primary)
        }
    }
}
