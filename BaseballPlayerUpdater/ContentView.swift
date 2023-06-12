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
    
    enum Tabs: String, CustomStringConvertible, Hashable {
        var description: String { rawValue }
        
        case plays
        case teams
    }
    
    
    
    var body: some View {
        TabView {
            
            NavigationStack {
                AllPlaysInBaseball()
            }
            .makeTab(tab: Tabs.plays, systemImage: "figure.baseball")
            
            
            NavigationStack {
                ListOfTeams()
            }
            .makeTab(tab: Tabs.teams, systemImage: "list.bullet")
            
            
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
