//
//  TeamRoster.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import Foundation

// MARK: - TeamRoster
struct TeamRoster: Codable {
    let copyright: String?
    let roster: [RosterPlayer]?
    let link: String?
    let teamID: Int?
    let rosterType: String?

    enum CodingKeys: String, CodingKey {
        case copyright, roster, link
        case teamID = "teamId"
        case rosterType
    }
}

// MARK: - Roster
struct RosterPlayer: Codable, Identifiable {
    let person: Person
    let jerseyNumber: String?
    let position: Position?
    let status: Status?
    let parentTeamID: Int?
    
    var id: Int {
        person.id
    }

    enum CodingKeys: String, CodingKey {
        case person, jerseyNumber, position, status
        case parentTeamID = "parentTeamId"
    }
}

// MARK: - Person
struct Person: Codable, Identifiable {
    let id: Int
    let fullName, link, firstName, lastName: String?
    let primaryNumber, birthDate: String?
    let currentAge: Int?
    let birthCity, birthStateProvince, birthCountry, height: String?
    let weight: Int?
    let active: Bool?
    let primaryPosition: Position?
    let useName, useLastName, middleName, boxscoreName: String?
    let nickName: String?
    let gender: Gender?
    let isPlayer, isVerified: Bool?
    let draftYear: Int?
    let pronunciation, mlbDebutDate: String?
    let batSide, pitchHand: RosterStatus?
    let nameFirstLast, nameSlug, firstLastName, lastFirstName: String?
    let lastInitName, initLastName, fullFMLName, fullLFMName: String?
    let strikeZoneTop, strikeZoneBottom: Double?
    let nameMatrilineal: String?
}

// MARK: - Status
struct RosterStatus: Codable {
    let code: PlayerRosterCode?
    let description: RosterDescription?
}

enum PlayerRosterCode: String, Codable {
    case a = "A"
    case l = "L"
    case r = "R"
    case s = "S"
}

enum RosterDescription: String, Codable {
    case active = "Active"
    case descriptionLeft = "Left"
    case descriptionRight = "Right"
    case descriptionSwitch = "Switch"
}

enum Gender: String, Codable {
    case m = "M"
}

// MARK: - Position
struct Position: Codable {
    let code: String?
    let name, type: PositionName?
    let abbreviation: String?
}

enum PositionName: String, Codable {
    case catcher = "Catcher"
    case infielder = "Infielder"
    case outfielder = "Outfielder"
    case pitcher = "Pitcher"
    case secondBase = "Second Base"
    case shortstop = "Shortstop"
    case thirdBase = "Third Base"
    case twoWayPlayer = "Two-Way Player"
    case designatedHitter = "Designated Hitter"
    case firstBase = "First Base"
    case outfield = "Outfield"
}
