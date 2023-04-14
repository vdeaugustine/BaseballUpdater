// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let scheduleForDate = try? JSONDecoder().decode(ScheduleForDate.self, from: jsonData)

import Foundation

// MARK: - ScheduleForDate
struct ScheduleForDate: Codable {
    let copyright: String?
    let totalItems, totalEvents, totalGames, totalGamesInProgress: Int?
    let dates: [DateElement]?
}

// MARK: - DateElement
struct DateElement: Codable {
    let date: String?
    let totalItems, totalEvents, totalGames, totalGamesInProgress: Int?
    let games: [Game]?
    let events: [JSONAny]?
}

// MARK: - Game
struct Game: Codable, Identifiable {
    var id: Int { gamePk }
    let gamePk: Int
    let link: String?
    let gameType: GameType?
    let season: String?
    let gameDate: String?
    let officialDate: String?
    let status: Status?
    let teams: GameTeams?
    let linescore: Linescore?
    let decisions: Decisions?
    let venue: Venue?
    let broadcasts: [Broadcast]?
    let content: Content?
    let seriesStatus: SeriesStatus?
    let isTie: Bool?
    let gameNumber: Int?
    let publicFacing: Bool?
    let doubleHeader: DoubleHeader?
    let gamedayType: GamedayType?
    let tiebreaker: DoubleHeader?
    let calendarEventID, seasonDisplay: String?
    let dayNight: DayNight?
    let scheduledInnings: Int?
    let reverseHomeAwayStatus: Bool?
    let inningBreakLength, gamesInSeries, seriesGameNumber: Int?
    let seriesDescription: Description?
    let recordSource: RecordSource?
    let ifNecessary: DoubleHeader?
    let ifNecessaryDescription: IfNecessaryDescription?
    
    var broadcastURL: URL? {
        guard let content = content,
              let firstEpgItem = content.media?.epg?.first?.items?.first,
              let contentID = firstEpgItem.contentID
        else { return nil }
        
        return URL(string:"https://www.mlb.com/tv/g\(gamePk)/v\(contentID)?affiliateId=MINISB#game_state=live")
        
//    https://www.mlb.com/tv/g{{thisGameID}}/v{{gameContentID}}?affiliateId=MINISB#game_state=live
    }
    
    var gameDescription: String? {
        guard let teams,
              let homeName = teams.home?.team?.name,
              let awayName = teams.away?.team?.name
        else {
            return nil
        }
        
        return "\(awayName) at \(homeName)"
        
        
        
    }
    
}

// MARK: - Broadcast
struct Broadcast: Codable {
    let id: Int?
    let name: String?
    let type: BroadcastType?
    let language: BroadcastLanguage?
    let homeAway: HomeAway?
    let callSign: String?
    let isNational: Bool?
    let videoResolution: VideoResolution?
}

enum HomeAway: String, Codable {
    case away = "away"
    case home = "home"
}

enum BroadcastLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case fr = "fr"
}

enum BroadcastType: String, Codable {
    case am = "AM"
    case fm = "FM"
    case tv = "TV"
}

// MARK: - VideoResolution
struct VideoResolution: Codable {
    let code: PlayerCode?
    let resolutionShort: ResolutionShort?
    let resolutionFull: ResolutionFull?
}

enum PlayerCode: String, Codable {
    case h = "H"
}

enum ResolutionFull: String, Codable {
    case highDefinition = "High Definition"
}

enum ResolutionShort: String, Codable {
    case hd = "HD"
}

// MARK: - Content
struct Content: Codable {
    let link: String?
    let editorial: Editorial?
    let media: Media?
    let highlights, summary, gameNotes: Editorial?
}

// MARK: - Editorial
struct Editorial: Codable {
}

// MARK: - Media
struct Media: Codable {
    let epg: [Epg]?
    let epgAlternate: [EpgAlternate]?
    let freeGame, enhancedGame: Bool?
}

// MARK: - Epg
struct Epg: Codable {
    let title: EpgTitle?
    let items: [EpgItem]?
}

// MARK: - EpgItem
struct EpgItem: Codable {
    let callLetters: String?
    let espnAuthRequired, tbsAuthRequired, espn2AuthRequired: Bool?
    let gameDate, contentID: String?
    let fs1AuthRequired: Bool?
    let mediaID: String?
    let mediaFeedType: MediaFeedTypeEnum?
    let mlbnAuthRequired, foxAuthRequired: Bool?
    let mediaFeedSubType: String?
    let freeGame: Bool?
    let id: Int?
    let abcAuthRequired: Bool?
    
    let description: String?
    let language: ItemLanguage?
    let type: MediaFeedTypeEnum?

    enum CodingKeys: String, CodingKey {
        case callLetters, espnAuthRequired, tbsAuthRequired, espn2AuthRequired, gameDate
        case contentID = "contentId"
        case fs1AuthRequired
        case mediaID = "mediaId"
        case mediaFeedType, mlbnAuthRequired, foxAuthRequired, mediaFeedSubType, freeGame, id, abcAuthRequired, description, language, type
    }
}

enum ItemLanguage: String, Codable {
    case en = "EN"
    case es = "es"
    case languageES = "ES"
    case languageEn = "en"
}

enum MediaFeedTypeEnum: String, Codable {
    case away = "AWAY"
    case empty = ""
    case home = "HOME"
}

enum MediaState: String, Codable {
    case mediaArchive = "MEDIA_ARCHIVE"
}

enum RenditionName: String, Codable {
    case english = "English"
    case englishRadio = "English Radio"
    case radioEspañola = "Radio Española"
}

enum EpgTitle: String, Codable {
    case audio = "Audio"
    case mlbtv = "MLBTV"
    case mlbtvAudio = "MLBTV-Audio"
}

// MARK: - EpgAlternate
struct EpgAlternate: Codable {
    let items: [EpgAlternateItem]?
    let title: EpgAlternateTitle?
}

// MARK: - EpgAlternateItem
struct EpgAlternateItem: Codable {
    let type: PurpleType?
    let state: GameState?
    let date, id, headline, seoTitle: String?
    let slug, blurb: String?
    let keywordsAll, keywordsDisplay: [Keywords]?
    let image: Image?
    let noIndex: Bool?
    let mediaPlaybackID, title, description, duration: String?
    let mediaPlaybackURL: String?
    let playbacks: [Playback]?

    enum CodingKeys: String, CodingKey {
        case type, state, date, id, headline, seoTitle, slug, blurb, keywordsAll, keywordsDisplay, image, noIndex
        case mediaPlaybackID = "mediaPlaybackId"
        case title, description, duration
        case mediaPlaybackURL = "mediaPlaybackUrl"
        case playbacks
    }
}

// MARK: - Image
struct Image: Codable {
    let title: String?
    let altText: JSONNull?
    let templateURL: String?
    let cuts: [Cut]?

    enum CodingKeys: String, CodingKey {
        case title, altText
        case templateURL = "templateUrl"
        case cuts
    }
}

// MARK: - Cut
struct Cut: Codable {
    let aspectRatio: AspectRatio?
    let width, height: Int?
    let src, at2X, at3X: String?

    enum CodingKeys: String, CodingKey {
        case aspectRatio, width, height, src
        case at2X = "at2x"
        case at3X = "at3x"
    }
}

enum AspectRatio: String, Codable {
    case the169 = "16:9"
    case the43 = "4:3"
    case the6427 = "64:27"
}

// MARK: - Keywords
struct Keywords: Codable {
    let type: KeywordsAllType?
    let value, displayName: String?
}

enum KeywordsAllType: String, Codable {
    case game = "game"
    case gamePk = "game_pk"
    case mlbtax = "mlbtax"
    case subject = "subject"
    case taxonomy = "taxonomy"
    case team = "team"
    case teamID = "team_id"
}

// MARK: - Playback
struct Playback: Codable {
    let name: Name?
    let url: String?
    let width, height: String?
}

enum Name: String, Codable {
    case highBit = "highBit"
    case hlsCloud = "hlsCloud"
    case httpCloudWired = "HTTP_CLOUD_WIRED"
    case httpCloudWired60 = "HTTP_CLOUD_WIRED_60"
    case mp4AVC = "mp4Avc"
    case trickplay = "trickplay"
}

enum GameState: String, Codable {
    case a = "A"
}

enum PurpleType: String, Codable {
    case video = "video"
}

enum EpgAlternateTitle: String, Codable {
    case dailyRecap = "Daily Recap"
    case extendedHighlights = "Extended Highlights"
}

enum DayNight: String, Codable {
    case day = "day"
    case night = "night"
}

// MARK: - Decisions
struct Decisions: Codable {
    let winner, loser, save: Loser?
}

// MARK: - Loser
struct Loser: Codable {
    let id: Int?
    let fullName, link: String?
}

enum DoubleHeader: String, Codable {
    case n = "N"
}

enum GameType: String, Codable {
    case r = "R"
}

enum GamedayType: String, Codable {
    case p = "P"
}

enum IfNecessaryDescription: String, Codable {
    case normalGame = "Normal Game"
}

// MARK: - Linescore
struct Linescore: Codable {
    let currentInning: Int?
    let currentInningOrdinal: CurrentInningOrdinal?
    let inningState, inningHalf: InningHalfEnum?
    let isTopInning: Bool?
    let scheduledInnings: Int?
    let innings: [Inning]?
    let teams: LinescoreTeams?
    let defense: Defense?
    let offense: Offense?
    let balls, strikes, outs: Int?
    let note: String?
}

enum CurrentInningOrdinal: String, Codable {
    case the10Th = "10th"
    case the1St = "1st"
    case the2Nd = "2nd"
    case the3RD = "3rd"
    case the4Th = "4th"
    case the5Th = "5th"
    case the6Th = "6th"
    case the7Th = "7th"
    case the8Th = "8th"
    case the9Th = "9th"
}

// MARK: - Defense
struct Defense: Codable {
    let pitcher, catcher, first, second: Loser?
    let third, shortstop, defenseLeft, center: Loser?
    let defenseRight, batter, onDeck, inHole: Loser?
    let battingOrder: Int?
    let team: Venue?

    enum CodingKeys: String, CodingKey {
        case pitcher, catcher, first, second, third, shortstop
        case defenseLeft = "left"
        case center
        case defenseRight = "right"
        case batter, onDeck, inHole, battingOrder, team
    }
}

// MARK: - Venue
struct Venue: Codable {
    let id: Int?
    let name, link: String?
    let abbreviation: Abbreviation?
}

enum Abbreviation: String, Codable {
    case cl = "CL"
    case gl = "GL"
}

enum InningHalfEnum: String, Codable {
    case bottom = "Bottom"
    case top = "Top"
}

// MARK: - Inning
struct Inning: Codable {
    let num: Int?
    let ordinalNum: CurrentInningOrdinal?
    let home, away: InningAway?
}

// MARK: - InningAway
struct InningAway: Codable {
    let runs, hits, errors, leftOnBase: Int?
}

// MARK: - Offense
struct Offense: Codable {
    let batter, onDeck, inHole, pitcher: Loser?
    let battingOrder: Int?
    let team: Venue?
    let first: Loser?
}

// MARK: - LinescoreTeams
struct LinescoreTeams: Codable {
    let home, away: InningAway?
}

enum RecordSource: String, Codable {
    case s = "S"
}

enum Description: String, Codable {
    case regularSeason = "Regular Season"
}

// MARK: - SeriesStatus
struct SeriesStatus: Codable {
    let gameNumber, totalGames: Int?
    let isTied, isOver: Bool?
    let wins, losses: Int?
    let winningTeam, losingTeam: IngTeam?
    let description: Description?
    let shortDescription: Short?
    let result: String?
    let shortName: Short?
}

// MARK: - IngTeam
struct IngTeam: Codable {
    let springLeague: Venue?
    let allStarStatus: DoubleHeader?
    let id: Int?
    let name, link: String?
}

enum Short: String, Codable {
    case season = "Season"
}

// MARK: - Status
struct Status: Codable {
    let abstractGameState: AbstractGameStateEnum?
    let codedGameState: AbstractGameCode?
    let detailedState: AbstractGameStateEnum?
    let statusCode: AbstractGameCode?
    let startTimeTBD: Bool?
    let abstractGameCode: AbstractGameCode?
}

enum AbstractGameCode: String, Codable {
    case f = "F"
}

enum AbstractGameStateEnum: String, Codable {
    case stateFinal = "Final"
}

// MARK: - GameTeams
struct GameTeams: Codable {
    let away, home: PurpleAway?
}

// MARK: - PurpleAway
struct PurpleAway: Codable {
    let leagueRecord: LeagueRecord?
    let score: Int?
    let team: Venue?
    let isWinner: Bool?
    let probablePitcher: Loser?
    let splitSquad: Bool?
    let seriesNumber: Int?
}

// MARK: - LeagueRecord
struct LeagueRecord: Codable {
    let wins, losses: Int?
    let pct: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

