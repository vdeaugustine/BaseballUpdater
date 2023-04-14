//
//  TeamDetailView.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import SwiftUI
import Vin

struct TeamDetailView: View {
    let team: Team
    
    var body: some View {
        List {
            Section(header: Text("Basic Info")) {
                if let name = team.name {
                    Text("Name: \(name)")
                }
                if let id = team.id {
                    Text("ID: \(id)")
                }
                if let season = team.season {
                    Text("Season: \(season.str)")
                }
                
            }
            
            Section(header: Text("Leagues and Divisions")) {
                if let leagueName = team.league?.name {
                    Text("League: \(leagueName)")
                }
                if let divisionName = team.division?.name {
                    Text("Division: \(divisionName)")
                }
                if let springLeagueName = team.springLeague?.name {
                    Text("Spring League: \(springLeagueName)")
                }
            }
            
            Section(header: Text("Venues")) {
                if let venueName = team.venue?.name {
                    Text("Home Venue: \(venueName)")
                }
            }
            
            Section(header: Text("Other Info")) {
//                if let teamCode = team.teamCode {
//                    Text("Team Code: \(teamCode)")
//                }
//                if let fileCode = team.fileCode {
//                    Text("File Code: \(fileCode)")
//                }
                if let abbreviation = team.abbreviation {
                    Text("Abbreviation: \(abbreviation)")
                }
                if let teamName = team.teamName {
                    Text("Team Name: \(teamName)")
                }
                if let locationName = team.locationName {
                    Text("Location Name: \(locationName)")
                }
                if let firstYearOfPlay = team.firstYearOfPlay {
                    Text("First Year of Play: \(firstYearOfPlay)")
                }
                if let shortName = team.shortName {
                    Text("Short Name: \(shortName)")
                }
                if let franchiseName = team.franchiseName {
                    Text("Franchise Name: \(franchiseName)")
                }
                if let clubName = team.clubName {
                    Text("Club Name: \(clubName)")
                }
                if let active = team.active {
                    Text("Active: \(active.description)")
                }
            }
        }
        .navigationTitle(team.name ?? "Unknown Team")
    }
}




struct TeamDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailView(team: .Angels)
    }
}
