//
//  ContentView.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import CoreData
import SwiftUI
import Vin

// MARK: - ContentView

struct ContentView: View {
    @State private var schedule: ScheduleForDate? = nil
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        List {
            if let schedule,
               let dates = schedule.dates,
               let todayGame = dates.first,
               let games = todayGame.games {
                ForEach(games) { game in
                    if let gameURL = game.broadcastURL,
                       let description = game.gameDescription {
                        Link(destination: gameURL) {
                            Text(description)
                        }
                    }
                }
            }
        }
        .onAppear {
            guard let url = URL(string: Links.getScheduleURL(for: .dateByAddingDays(-1))) else {
                return
            }

            fetchJSON(url: url) { (result: Result<ScheduleForDate, Error>) in
                DispatchQueue.main.async {
                    switch result {
                        case let .success(success):
                            schedule = success
                        case let .failure(failure):
                            showAlert = true
                            alertMessage = "Failed to fetch schedule: \(failure.localizedDescription)"
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
