//
//  SettingsView.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import SwiftUI
import Vin

// MARK: - SettingsView

struct SettingsView: View {
    @State private var notificationTime: NotificationTime = .atBat

    var body: some View {
        Form {
            Picker("Notify when batter is", selection: $notificationTime) {
                Text("At Bat").tag(NotificationTime.atBat)
                Text("On Deck").tag(NotificationTime.onDeck)
                Text("In the Hole").tag(NotificationTime.inTheHole)
            }
        }
        .navigationTitle("Settings")
    }
}

// MARK: - NotificationTime

enum NotificationTime: String, CaseIterable {
    case atBat = "At Bat"
    case onDeck = "On Deck"
    case inTheHole = "In the Hole"
}

// MARK: - SettingsView_Previews

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
            
    }
}
