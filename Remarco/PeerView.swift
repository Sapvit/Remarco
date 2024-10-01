//
//  PeerView.swift
//  Remarco
//
//  Created by Nikolay Khort on 04.01.2024.
//

import SwiftUI

struct PeerComment: Identifiable {
    var id = UUID()
    var text: String
}

struct Contact: Identifiable {
    var id = UUID()
    var name: String
    var email: String
    var telegram: String
}

struct Meeting: Identifiable {
    var id = UUID()
    var date: String
    var name: String
    var summary: String
}

struct ReminderRowView: View {
    var reminder: String

    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(ColorScheme.lightCompletedReminder)
                .padding(.trailing, 5)

            Text(reminder)
                .foregroundColor(ColorScheme.lightBodyText)
        }
    }
}

struct AttachmentRowView: View {
    var attachment: String

    var body: some View {
        HStack {
            Image(systemName: "doc.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 25)
                .foregroundColor(Color.gray)
                .padding(.trailing, 5)

            Text(attachment)
                .foregroundColor(ColorScheme.lightBodyText)
        }
    }
}

struct PeerCardView: View {
    var peer: Peer
    @State private var peerComment: PeerComment = PeerComment(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.")

    @State private var contacts: [Contact] = [
        Contact(name: "John Doe", email: "john.doe@example.com", telegram: "@johndoe"),
        Contact(name: "Jane Smith", email: "jane.smith@example.com", telegram: "@janesmith")
    ]

    @State private var meetings: [Meeting] = [
        Meeting(date: "01-01-2022", name: "Project Kick-off", summary: "Summary 1"),
        Meeting(date: "05-01-2022", name: "Progress Update", summary: "Summary 2"),
        Meeting(date: "10-01-2022", name: "Planning Session", summary: "Summary 3"),
        Meeting(date: "15-01-2022", name: "Final Review", summary: "Summary 4")
    ]

    @State private var isAddingContact = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(peer.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(ColorScheme.lightTitleText)
                    Text(peer.nickname ?? "")
                        .foregroundColor(ColorScheme.lightSubheadingText)
                }
                
                TextEditor(text: $peerComment.text)
                                    .background(ColorScheme.lightBackgroundColor)
                                    .foregroundColor(ColorScheme.lightBodyText)
                                    .cornerRadius(10)
                                    .padding(.leading)
                                    .frame(height:120)
                                    .frame(maxWidth: .infinity)
                                    .scrollContentBackground(.hidden)

                //Spacer()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        Spacer()
                        Button(action: {
                            isAddingContact.toggle()
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.blue)
                        }
                        .sheet(isPresented: $isAddingContact) {
                            AddContactView(isAddingContact: $isAddingContact, contacts: $contacts)
                        }
                        
                        ForEach(contacts) { contact in
                            ContactCardView(contact: contact)
                        }
                    }
                    .padding(.trailing, 10)
                }.frame(maxWidth: 400)
            }
            .padding()

        //08.01.24 - Trying to make navigationView here:
            /*NavigationView {
                List {
                    ForEach(meetings.sorted { $0.date > $1.date }) { meeting in
                        MeetingRowView(meeting: meeting)
                            //.listRowBackground(ColorScheme.lightBackgroundColor)
                    }
                }.listStyle(PlainListStyle())
                    .padding(.top)
            }.navigationTitle("Meetings")*/
            
            List {
                ForEach(meetings.sorted { $0.date > $1.date }) { meeting in
                    MeetingRowView(meeting: meeting)
                        //.listRowBackground(ColorScheme.lightBackgroundColor)
                }
            }.listStyle(PlainListStyle())
                .padding(.top)

            Divider()
            
            /*Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(red: 0.6, green: 0.4, blue: 0.2)) // Brown color
            */
            
            HStack(alignment: .top, spacing: 10) {
                // Left Section - Reminders
                VStack(alignment: .leading, spacing: 15) {
                    Text("Reminders")
                        .font(.headline)
                        .foregroundColor(ColorScheme.lightHeadingText)
                        .padding(.bottom, 5)
                    
                    // Example reminders (adjust as needed)
                    ForEach(1...4, id: \.self) { index in
                        ReminderRowView(reminder: "Reminder \(index)")
                    }
                }
                .padding()
                .background(ColorScheme.lightBackgroundColor)
                
                Spacer()
                //Spacer().frame(width: 20) // Adjust spacing between sections
                
                // Right Section - Attachments
                VStack(alignment: .leading) {
                    Text("Attachments")
                        .font(.headline)
                        .foregroundColor(ColorScheme.lightHeadingText)
                        .padding(.bottom, 5)
                    
                    // Example attachments (adjust as needed)
                    ForEach(1...4, id: \.self) { index in
                        AttachmentRowView(attachment: "Attachment \(index)")
                    }
                }
                .padding()
                .background(ColorScheme.lightBackgroundColor)
                Spacer()
            }
        }
        .padding()
        .background(ColorScheme.lightBackgroundColor)
        .navigationTitle("Peer Card")
    }
}

struct ContactCardView: View {
    var contact: Contact

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(contact.name)
                .font(.headline)
            Text(contact.email)
                .foregroundColor(ColorScheme.lightSubheadingText)
                .font(.caption)
                .lineLimit(1)
            Text(contact.telegram)
                .foregroundColor(ColorScheme.lightSubheadingText)
                .font(.caption)
        }
        .padding()
        .frame(width: 150, height: 120)
        .background(ColorScheme.lightCardBackgroundColor)
        .cornerRadius(10)
    }
}

struct AddContactView: View {
    @Binding var isAddingContact: Bool
    @Binding var contacts: [Contact]

    @State private var newName = ""
    @State private var newEmail = ""
    @State private var newTelegram = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("New Contact")) {
                        TextField("Name", text: $newName)
                        TextField("Email", text: $newEmail)
                        TextField("Telegram", text: $newTelegram)
                    }
                }

                Button(action: {
                    contacts.append(Contact(name: newName, email: newEmail, telegram: newTelegram))
                    isAddingContact = false
                }) {
                    Text("Add Contact")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .background(ColorScheme.lightBackgroundColor)
            .navigationTitle("Add Contact")
        }
    }
}

struct MeetingRowView: View {
    var meeting: Meeting

    var body: some View {
        DisclosureGroup {
            Button(action: {
                //showSidePanel.toggle()
            }) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Date: \(meeting.date)")
                        .font(.headline)
                    Text("Name: \(meeting.name)")
                        .font(.subheadline)
                    Text("\(meeting.summary) - \(meeting.id)")
                        .font(.subheadline)
                }
            }.padding()
                .foregroundColor(.black)
            
        } label: {
            Text("\(meeting.date) - \(meeting.name)")
                .foregroundColor(ColorScheme.lightHeadingText)
                .font(.headline)
        }
        .padding(.vertical, 5)
        .background(ColorScheme.lightBackgroundColor)
        .listRowBackground(ColorScheme.lightBackgroundColor) // Set the background color for the list row
        .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let examplePeer = Peer(name: "Example Corp", nickname: "ExCorp", contactName: "John Doe", email: "john.doe@example.com", telegramLink: "@johndoe", category: .clients)
        PeerCardView(peer: examplePeer)
    }
}
