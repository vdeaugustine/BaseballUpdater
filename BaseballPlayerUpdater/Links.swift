//
//  Links.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import Foundation

enum Links {
    
    static func getScheduleURL(for date: Date = .now) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return "https://statsapi.mlb.com/api/v1/schedule?date=\(formattedDate)&sportId=1&hydrate=decisions,probablePitcher(note),linescore,broadcasts,game(content(media(epg))),seriesStatus"
        
    }
    
    static func getOnDeck(for gameId: Int) -> String {
        "https://statsapi.mlb.com/api/v1.1/game/\(gameId)/feed/live?fields=liveData,linescore,offense,onDeck,id,fullName,link"
    }
}

func fetchJSON<T: Codable>(url: URL, completion: @escaping (T?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error)
            return
        }
        
        guard let data = data else {
            print("Data was nil")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)
            completion(decodedObject)
        } catch {
            print("Couldn't parse JSON as \(T.self):\n\(error)")
        }
    }.resume()
}



 
