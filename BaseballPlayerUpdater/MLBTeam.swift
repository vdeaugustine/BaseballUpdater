// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mLBTeam = try? JSONDecoder().decode(MLBTeam.self, from: jsonData)

import Foundation

// MARK: - MLBTeam
struct MLBTeams: Codable {
    let copyright: String?
    let teams: [Team]?
}

// MARK: - Team
struct Team: Codable, Identifiable, Hashable {
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(name)
           hasher.combine(abbreviation)
           hasher.combine(shortName)
           hasher.combine(franchiseName)
           hasher.combine(clubName)
       }
    
    let springLeague: Division?
    let allStarStatus: AllStarStatus?
    let id: Int?
    let name, link: String?
    let season: Int?
    let venue: Division?
    let springVenue: SpringVenue?
    let teamCode, fileCode, abbreviation, teamName: String?
    let locationName, firstYearOfPlay: String?
    let league, division, sport: Division?
    let shortName, franchiseName, clubName: String?
    let active: Bool?
    
    static let Angels: Team = {
        let json = """
        {
            "springLeague": {
                "id": 114,
                "name": "Cactus League",
                "link": "/api/v1/league/114",
                "abbreviation": "CL"
            },
            "allStarStatus": "N",
            "id": 108,
            "name": "Los Angeles Angels",
            "link": "/api/v1/teams/108",
            "season": 2023,
            "venue": {
                "id": 1,
                "name": "Angel Stadium",
                "link": "/api/v1/venues/1"
            },
            "springVenue": {
                "id": 2500,
                "link": "/api/v1/venues/2500"
            },
            "teamCode": "ana",
            "fileCode": "ana",
            "abbreviation": "LAA",
            "teamName": "Angels",
            "locationName": "Anaheim",
            "firstYearOfPlay": "1961",
            "league": {
                "id": 103,
                "name": "American League",
                "link": "/api/v1/league/103"
            },
            "division": {
                "id": 200,
                "name": "American League West",
                "link": "/api/v1/divisions/200"
            },
            "sport": {
                "id": 1,
                "link": "/api/v1/sports/1",
                "name": "Major League Baseball"
            },
            "shortName": "LA Angels",
            "franchiseName": "Los Angeles",
            "clubName": "Angels",
            "active": true
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        return try! decoder.decode(Team.self, from: json)
    }()
}

enum AllStarStatus: String, Codable {
    case n = "N"
}

// MARK: - Division
struct Division: Codable {
    let id: Int?
    let name, link: String?
    let abbreviation: Abbreviation?
}


// MARK: - SpringVenue
struct SpringVenue: Codable {
    let id: Int?
    let link: String?
}

