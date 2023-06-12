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

/**
 A collection of URLs for retrieving information related to MLB games and teams.
 */
enum Links {
    /**
     Returns the URL for the MLB schedule for a given date.

     - Parameter date: The date for which to retrieve the schedule. Defaults to the current date.
     - Returns: The URL for the MLB schedule for the given date.
     */
    static func getScheduleURL(for date: Date = .now) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return "https://statsapi.mlb.com/api/v1/schedule?date=\(formattedDate)&sportId=1&hydrate=decisions,probablePitcher(note),linescore,broadcasts,game(content(media(epg))),seriesStatus"
    }

    /**
     Returns the URL for the on-deck information for a given game ID.

     - Parameter gameId: The ID of the game for which to retrieve the on-deck information.
     - Returns: The URL for the on-deck information for the given game ID.
     */
    static func getOnDeck(for gameId: Int) -> String {
        "https://statsapi.mlb.com/api/v1.1/game/\(gameId)/feed/live?fields=liveData,linescore,offense,onDeck,id,fullName,link"
    }

    /// The URL for retrieving information about all MLB teams.
    static let mlbTeams: String = "https://statsapi.mlb.com/api/v1/teams?sportId=1&leagueIds=103,104"

    /**
     Returns the URL for the roster of a given team.

     - Parameter id: The ID of the team for which to retrieve the roster.
     - Returns: The URL for the roster of the given team.
     */
    static func teamRoster(_ id: Int) -> String {
        "https://statsapi.mlb.com/api/v1/teams/\(id)/roster?hydrate=person"
    }
    
    
    static func playerImage(id: Int) -> String {
        "https://img.mlbstatic.com/mlb-photos/image/upload/d_people:generic:headshot:67:current.png/w_213,q_auto:best/v1/people/\(id)/headshot/67/current"
    }
    
    
}

/**
 Fetches JSON data from the specified URL and decodes it into the specified type using JSONDecoder. Calls the completion handler with the decoded object or an error if there was an issue with the request or decoding.

 - Parameter url: The URL from which to fetch JSON data.
 - Parameter completion: The completion handler to call with the decoded object or an error.
 */

func fetchJSON<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
    // Use URLSession to create a data task that retrieves data from the specified URL
    URLSession.shared.dataTask(with: url) { data, _, error in

        // If there was an error, call the completion handler with the error
        if let error = error {
            completion(.failure(error))
            return
        }

        // If there is no data, call the completion handler with an error
        guard let data = data else {
            completion(.failure(NSError(domain: "fetchJSON", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data was nil"])))
            return
        }

        // Use JSONDecoder to decode the retrieved data into the specified type
        do {
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: data)
            completion(.success(decodedObject))
        } catch {
            // If there was an error decoding the data, call the completion handler with the error
            completion(.failure(error))
        }
    }.resume()
}
