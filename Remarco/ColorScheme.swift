//
//  ColorScheme.swift
//  Remarco
//
//  Created by Nikolay Khort on 04.01.2024.
//

import SwiftUI

struct ColorScheme {
    // Light Mode
    static let lightBackgroundColor = Color(red: 242/255, green: 234/255, blue: 221/255)
    static let lightCardBackgroundColor = Color(red: 212/255, green: 171/255, blue: 125/255)

    static let lightPrimaryText = Color.black
    static let lightSecondaryText = Color.gray

    static let lightTitleText = Color.black
    static let lightHeadingText = Color.black
    static let lightSubheadingText = Color.blue
    static let lightBodyText = Color.black

    static let lightOutdatedReminder = Color.red
    static let lightCompletedReminder = Color.green
    static let lightActiveReminder = Color.blue

    // Dark Mode
    static let darkBackgroundColor = Color.black
    static let darkCardBackgroundColor = Color(red: 0.2, green: 0.2, blue: 0.2)

    static let darkPrimaryText = Color.white
    static let darkSecondaryText = Color.gray

    static let darkTitleText = Color.white
    static let darkHeadingText = Color.blue
    static let darkSubheadingText = Color.gray
    static let darkBodyText = Color.white

    static let darkOutdatedReminder = Color.red
    static let darkCompletedReminder = Color.green
    static let darkActiveReminder = Color.blue
}


struct FishText {
    static let shortText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    static let longText = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
}
