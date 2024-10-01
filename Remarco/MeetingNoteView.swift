//
//  MeetingNoteView.swift
//  Remarco
//
//  Created by Nikolay Khort on 05.01.2024.
//

import SwiftUI

struct MeetingNoteView: View {
    @ObservedObject var meetingNote: MeetingNote

    @State private var name: String
    @State private var summaryText: String
    @State private var notesText: String
    @State private var date: Date
    @State private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MMM.yyyy"
        return formatter
    }()
    @State private var isDatePickerPresented: Bool = false
    @State private var showSidePanel: Bool = false

    init(meetingNote: MeetingNote) {
        _meetingNote = ObservedObject(wrappedValue: meetingNote)
        _name = State(initialValue: meetingNote.name)
        _summaryText = State(initialValue: meetingNote.summary)
        _notesText = State(initialValue: meetingNote.notes)
        _date = State(initialValue: meetingNote.date)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Meeting Name:")
                                .font(.headline)
                            TextField("Meeting Name", text: $name)
                                .cornerRadius(10)
                                .font(.headline)
                        }.background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                        Button(action: {
                            isDatePickerPresented.toggle()
                        }) {
                            Text("Date: \(dateFormatter.string(from: meetingNote.date))")
                                .font(.headline)
                                .sheet(isPresented: $isDatePickerPresented) {
                                    DatePicker("Select a Date", selection: $date, in: ...Date(), displayedComponents: .date)
                                        .datePickerStyle(GraphicalDatePickerStyle())
                                        .padding()
                                        .onChange(of: date) { newDate in
                                            // Update the meetingNote.date when the DatePicker value changes
                                            meetingNote.date = newDate
                                            isDatePickerPresented.toggle()
                                        }
                                }
                        }.foregroundColor(.black)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(5)
                        //Spacer()
                    }
                    Button(action: {
                        showSidePanel.toggle()
                    }) {
                        Image(systemName: "sidebar.right")
                    }.padding()
                        .foregroundColor(.black)
                    /*RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .foregroundColor(.brown)
                        .frame(width: 200, height: 100)
                        .padding()
                        .opacity(0.2)*/
                }.frame(height: 70)
                Divider()
                Text("Summary:")
                    .font(.headline)
                TextEditor(text: $summaryText)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .frame(height: 100)
                    .scrollContentBackground(.hidden)
                
                Text("Meeting Notes:")
                    .font(.headline)
                TextEditor(text: $notesText)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .scrollContentBackground(.hidden)
            }
            .padding()
            .navigationTitle("Meeting Note")
            //.offset(x: showSidePanel ? -200 : 0)
            
            if showSidePanel {
                Divider()
                SidePanelView()
                    .frame(width: 300)
                    .animation(.spring(duration: 1, bounce: 0.9), value: 2.0)
                
                //doesn't work in preview pane?
            }
        }.background(ColorScheme.lightBackgroundColor)
    }
}


struct SidePanelView: View {
    var body: some View {
        // Your side panel content goes here
        VStack {
            RemindersListView()
                .padding(.vertical)
        }
    }
}


struct MeetingNoteView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleMeetingNote = MeetingNote(
            date: Date(),
            name: "Project Kick-off",
            summary: FishText.shortText,
            notes: FishText.longText,
            reminders: [
                Reminder(title: "Prepare slides", isComplete: false, meetingNoteID: UUID(), peerID: UUID()),
                Reminder(title: "Review agenda", isComplete: false, meetingNoteID: UUID(), peerID: UUID())
            ],
            attachments: [Attachment(name: "Meeting Agenda", icon: "doc.fill")],
            peerID: UUID()
        )
        return MeetingNoteView(meetingNote: exampleMeetingNote)
    }
}

