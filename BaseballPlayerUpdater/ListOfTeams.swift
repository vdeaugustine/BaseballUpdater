//
//  ListOfTeams.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import SwiftUI

// MARK: - ListOfTeams

struct ListOfTeams: View {
    @State private var teamsObject: MLBTeams? = nil
    
    /// The body of the view.
    var body: some View {
        List {
            if let teams = teamsObject?.teams {
                ForEach(teams.sorted(by: {$0.id! < $1.id!})) { team in
                    if let name = team.clubName {
                        NavigationLink {
                            TeamDetailView(team: team)
                        } label: {
                            Text(name)
                        }

                    }
                }
            }
        }
        .onAppear {
            if let url = URL(string: Links.mlbTeams) {
                fetchJSON(url: url) { (result: Result<MLBTeams, Error>) in
                    switch result {
                        case let .success(success):
                            DispatchQueue.main.async {
                                teamsObject = success
                            }
                        case .failure:
                            break
                    }
                }
            }
        }
        
    }
}



// MARK: - ListOfTeams_Previews

struct ListOfTeams_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListOfTeams()
        }
    }
}
