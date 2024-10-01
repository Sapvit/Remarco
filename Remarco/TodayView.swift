//
//  TodayView.swift
//  Remarco
//
//  Created by Nikolay Khort on 05.01.2024.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Today")
                .font(.title)
                .foregroundColor(ColorScheme.lightTitleText)

            List {
                Section(header: Text("Meetings")) {
                    ForEach(1...5, id: \.self) { index in
                        Text("Meeting \(index)")
                    }
                }

                Section(header: Text("Reminders Widget")) {
                    ForEach(1...3, id: \.self) { index in
                        Text("Reminder \(index)")
                    }
                }
            }
            .listRowBackground(ColorScheme.lightBackgroundColor)
        }
        .padding()
        .background(ColorScheme.lightBackgroundColor)
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
