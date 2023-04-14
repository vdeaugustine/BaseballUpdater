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
               let dates = schedule.dates,
               let todayGame = dates.first,
               let games = todayGame.games {
                ForEach(games) { game in
                    if let gameURL = game.broadcastURL,
                       let description = game.gameDescription{
                        Link(destination: gameURL) {
                            Text(description)
                        }
                    }
                        
                }
            }
        }
        .onAppear {
            let url = URL(string: Links.getScheduleURL())!
            
            fetchJSON(url: url) { retSched in
                
                DispatchQueue.main.async {
                    schedule = retSched
                    print(String(describing: schedule))
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
