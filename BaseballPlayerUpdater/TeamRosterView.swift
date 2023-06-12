//
//  TeamRosterView.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import SwiftUI
import Vin

// MARK: - TeamRosterView

struct TeamRosterView: View {
    let teamCode: Int
    @State private var roster: TeamRoster? = nil
    @State private var alertMessage: String = ""
    @State private var error: LocalizedError? = nil
    @State private var showAlert = false
    var body: some View {
        VStack {
            if roster == nil {
                ProgressView()
            } else {
                List {
                    if let roster,
                       let players = roster.roster {
                        ForEach(players) { player in
                            if let name = player.person.fullName {
                                HStack {
                                    PlayerImage(url: URL(string: Links.playerImage(id: player.id))!)
                                        .frame(height: 60)

                                    Text(name)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if let url = URL(string: Links.teamRoster(teamCode)) {
                fetchJSON(url: url) { (result: Result<TeamRoster, Error>) in
                    DispatchQueue.main.async {
                        switch result {
                            case let .success(success):
                                roster = success
                            case let .failure(failure):
                                print(failure)
                                alertMessage = "Could not load roster. Please try again later."
                        }
                    }
                }
            }
        }

        
    }
}

// MARK: - TeamRosterView_Previews

struct TeamRosterView_Previews: PreviewProvider {
    static var previews: some View {
        TeamRosterView(teamCode: 134)
    }
}
