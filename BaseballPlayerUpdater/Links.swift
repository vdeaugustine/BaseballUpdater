//
//  Links.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import Foundation

extension Date {
    static func dateByAddingDays(_ days: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = days
        return calendar.date(byAdding: dateComponents, to: .now)!
    }
}


// MARK: - Links

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

func fetchJSON<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, _, error in

        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "fetchJSON", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was nil"])))
            return
        }

        do {
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)
            completion(.success(decodedObject))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}
