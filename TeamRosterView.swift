//
//  TeamRosterView.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import SwiftUI
import Vin
struct TeamRosterView: View {
    let teamCode: Int
    @State private var roster: TeamRoster? = nil
    @State private var alertMessage: String = ""
    @State private var error: LocalizedError? = nil
    @State private var showAlert = false
    var body: some View {
        List {
            if let roster,
               let players = roster.roster {
                ForEach(players) { player in
                    if let name = player.person.fullName {
                        Text(name)
                    }
                }
            }
        }
        
        
        
        .onAppear {
            if let url = URL(string: Links.teamRoster(teamCode)) {
                fetchJSON(url: url) { (result: Result<TeamRoster, Error>) in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            roster = success
                        case .failure(let failure):
                            
                            alertMessage = "Could not load roster. Please try again later."
                        }
                    }
                }
            }
        }
    }
}

struct TeamRosterView_Previews: PreviewProvider {
    static var previews: some View {
        TeamRosterView(teamCode: 108)
    }
}
