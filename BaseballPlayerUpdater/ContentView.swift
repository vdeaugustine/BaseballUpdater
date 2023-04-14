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

    var body: some View {
        List {
            Text("Watch MLB Game")
                .font(.title)

            Link("Watch Game",
                 destination: URL(string: "https://www.mlb.com")!)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            
            

            if let schedule,
               let games = schedule.dates,
               let todayGame = games.first,
               let games = todayGame.games {
                ForEach(games) { game in
                    Link(destination: <#T##URL#>) { 
                        <#code#>
                    }
                        
                }
            }
        }
        .onAppear {
            let url = URL(string: "https://statsapi.mlb.com/api/v1/schedule?date=2023-04-12&sportId=1")!
            
            fetchJSON(url: url) { retSched in
                
                DispatchQueue.main.async {
                    schedule = retSched
                }
                
                
            }
            
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
