//
//  AllPlaysInBaseball.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 6/11/23.
//

import SwiftUI
import Vin

// MARK: - AllPlaysInBaseball

struct AllPlaysInBaseball: View {
    @State private var allPlays = [Play]()
    @State private var showTweetConfirmation = false
    @State private var showSpinner = false

    var body: some View {
        ZStack {
            List {
                if allPlays.isEmpty, !showSpinner {
                    Text("Pull down to load")
                }

                ForEach(allPlays) { play in

                    HStack {
                        if let url = URL(string: Links.playerImage(id: play.matchup.batter.id)) {
                            PlayerImage(url: url)
                                .frame(height: 60)
                        }

                        VStack(alignment: .leading) {
                            Text(play.result.description)
                            Text(play.playTime)
                        }
                    }
                }
            }
            .refreshable {
                showSpinner = true
                await fetchAction()
//                showSpinner = false
            }
//            .toolbar {
//                ToolbarItem {
//                    Button {
//                        Task {
//                            await fetchAction()
//                        }
//                    } label: {
//                        Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
//                    }
//                }
//            }
            
            if showSpinner {
                ProgressView()
            }
        }

//        .task {
//            fetchAction()
//        }
    }

    func fetchAction() async {
        Task {
            
            let packs = try! await getGamePacks()
            var pbps: [PlayByPlay] = []
            for pack in packs {
                if let pbp = await getPlayByPlay(forGame: pack) {
                    pbps.append(pbp)
                }
            }
            let plays: [Play] = pbps.compactMap { $0.allPlays }.flatMap { $0 }

            let sortedPlays: [Play] = plays.sorted { firstPlay, secondPlay in
                convertToDate(dateString: firstPlay.playEndTime) ?? .distantFuture < convertToDate(dateString: secondPlay.playEndTime) ?? .distantFuture
            }

            allPlays = sortedPlays
            showSpinner = false

            func convertToDate(dateString: String) -> Date? {
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

                return dateFormatter.date(from: dateString)
            }

            func formatDate(_ date: Date) -> String {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM-dd HH:mm a"
                return formatter.string(from: date)
            }
        }
    }
}

extension AllPlaysInBaseball {
    // MARK: - GetGamePacks

    struct GetGamePacks: Codable {
        let dates: [DateElement]
    }

    // MARK: - DateElement

    struct DateElement: Codable {
        let games: [GamePackGame]
    }

    // MARK: - Game

    struct GamePackGame: Codable {
        let gamePk: Int
    }

    func getGamePacks(forDate date: Date = Date()) async throws -> [Int] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let formattedDate = formatter.string(from: date)

        guard let url = URL(string: "https://statsapi.mlb.com/api/v1/schedule?date=\(formattedDate)&sportId=1&fields=dates,games,gamePk") else {
            fatalError("Invalid URL")
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            let gamePacks = try decoder.decode(GetGamePacks.self, from: data)

            let gamePkValues = gamePacks.dates.flatMap { $0.games.map { $0.gamePk } }
            return gamePkValues
        } catch {
            throw error
        }
    }
}

extension AllPlaysInBaseball {
    // MARK: - PlayByPlay

    struct PlayByPlay: Codable, Hashable {
        let allPlays: [Play]?
    }

    // MARK: - Play

    struct Play: Codable, Hashable, Identifiable {
        var id: Play { self }

        let result: Result
        let about: About
        let count: Count
        let matchup: Matchup
        let playEvents: [PlayEvent]
        let playEndTime: String

        var playTime: String {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            return dateFormatter.date(from: playEndTime)?.getFormattedDate(format: "h:m a d/MM") ?? ""
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(result)
            hasher.combine(about)
            hasher.combine(count)
            hasher.combine(matchup)
            hasher.combine(playEvents)
            hasher.combine(playEndTime)
        }

        static func == (lhs: Play, rhs: Play) -> Bool {
            return lhs.result == rhs.result &&
                lhs.about == rhs.about &&
                lhs.count == rhs.count &&
                lhs.matchup == rhs.matchup &&
                lhs.playEvents == rhs.playEvents &&
                lhs.playEndTime == rhs.playEndTime
        }
    }

    // MARK: - About

    struct About: Codable, Hashable {
        let halfInning: HalfInning
        let isTopInning: Bool
        let inning: Int
        let startTime, endTime: String
        let isComplete, isScoringPlay, hasOut: Bool
        let captivatingIndex: Int

        func hash(into hasher: inout Hasher) {
            hasher.combine(halfInning)
            hasher.combine(isTopInning)
            hasher.combine(inning)
            hasher.combine(startTime)
            hasher.combine(endTime)
            hasher.combine(isComplete)
            hasher.combine(isScoringPlay)
            hasher.combine(hasOut)
            hasher.combine(captivatingIndex)
        }

        static func == (lhs: About, rhs: About) -> Bool {
            return lhs.halfInning == rhs.halfInning &&
                lhs.isTopInning == rhs.isTopInning &&
                lhs.inning == rhs.inning &&
                lhs.startTime == rhs.startTime &&
                lhs.endTime == rhs.endTime &&
                lhs.isComplete == rhs.isComplete &&
                lhs.isScoringPlay == rhs.isScoringPlay &&
                lhs.hasOut == rhs.hasOut &&
                lhs.captivatingIndex == rhs.captivatingIndex
        }
    }

    // MARK: - HalfInning

    enum HalfInning: String, Codable {
        case bottom
        case top
    }

    // MARK: - Count

    struct Count: Codable, Hashable {
        let balls, strikes, outs: Int

        func hash(into hasher: inout Hasher) {
            hasher.combine(balls)
            hasher.combine(strikes)
            hasher.combine(outs)
        }

        static func == (lhs: Count, rhs: Count) -> Bool {
            return lhs.balls == rhs.balls &&
                lhs.strikes == rhs.strikes &&
                lhs.outs == rhs.outs
        }
    }

    // MARK: - Matchup

    struct Matchup: Codable, Hashable {
        let batter, pitcher: PlayerClass
        let pitchHand: PitchHand
        let splits: Splits

        func hash(into hasher: inout Hasher) {
            hasher.combine(batter)
            hasher.combine(pitcher)
            hasher.combine(pitchHand)
            hasher.combine(splits)
        }

        static func == (lhs: Matchup, rhs: Matchup) -> Bool {
            return lhs.batter == rhs.batter &&
                lhs.pitcher == rhs.pitcher &&
                lhs.pitchHand == rhs.pitchHand &&
                lhs.splits == rhs.splits
        }
    }

    // MARK: - PlayerClass

    struct PlayerClass: Codable, Hashable {
        let id: Int
        let fullName, link: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(fullName)
            hasher.combine(link)
        }

        static func == (lhs: PlayerClass, rhs: PlayerClass) -> Bool {
            return lhs.id == rhs.id &&
                lhs.fullName == rhs.fullName &&
                lhs.link == rhs.link
        }
    }

    // MARK: - PitchHand

    struct PitchHand: Codable, Hashable {
        let description: Description

        func hash(into hasher: inout Hasher) {
            hasher.combine(description)
        }

        static func == (lhs: PitchHand, rhs: PitchHand) -> Bool {
            return lhs.description == rhs.description
        }
    }

    // MARK: - Description

    enum Description: String, Codable {
        case automaticBall = "Automatic Ball"
        case automaticBallPitcherTimerViolation = "Automatic Ball - Pitcher Pitch Timer Violation"
        case ball = "Ball"
        case ballInDirt = "Ball In Dirt"
        case calledStrike = "Called Strike"
        case changeup = "Changeup"
        case curveball = "Curveball"
        case cutter = "Cutter"
        case descriptionLeft = "Left"
        case descriptionRight = "Right"
        case foul = "Foul"
        case foulBunt = "Foul Bunt"
        case foulTip = "Foul Tip"
        case fourSeamFastball = "Four-Seam Fastball"
        case hitByPitch = "Hit By Pitch"
        case inPlayNoOut = "In play, no out"
        case inPlayOutS = "In play, out(s)"
        case inPlayRunS = "In play, run(s)"
        case knuckleCurve = "Knuckle Curve"
        case sinker = "Sinker"
        case slider = "Slider"
        case splitter = "Splitter"
        case sweeper = "Sweeper"
        case swingingStrike = "Swinging Strike"
        case swingingStrikeBlocked = "Swinging Strike (Blocked)"
    }

    // MARK: - Splits

    struct Splits: Codable, Hashable {
        let batter: BatterEnum
        let pitcher: Pitcher
        let menOnBase: MenOnBase

        func hash(into hasher: inout Hasher) {
            hasher.combine(batter)
            hasher.combine(pitcher)
            hasher.combine(menOnBase)
        }

        static func == (lhs: Splits, rhs: Splits) -> Bool {
            return lhs.batter == rhs.batter &&
                lhs.pitcher == rhs.pitcher &&
                lhs.menOnBase == rhs.menOnBase
        }
    }

    // MARK: - BatterEnum

    enum BatterEnum: String, Codable {
        case vsLHP = "vs_LHP"
        case vsRHP = "vs_RHP"
    }

    // MARK: - MenOnBase

    enum MenOnBase: String, Codable {
        case empty = "Empty"
        case loaded = "Loaded"
        case menOn = "Men_On"
        case risp = "RISP"
    }

    // MARK: - Pitcher

    enum Pitcher: String, Codable {
        case vsLHB = "vs_LHB"
        case vsRHB = "vs_RHB"
    }

    // MARK: - PlayEvent

    struct PlayEvent: Codable, Hashable {
        let details: Details
        let count: Count
        let startTime, endTime: String
        let type: PlayEventType
        let player: Player?
        let hitData: HitData?
        let playID: String?
        let pitchNumber: Int?

        func hash(into hasher: inout Hasher) {
            hasher.combine(details)
            hasher.combine(count)
            hasher.combine(startTime)
            hasher.combine(endTime)
            hasher.combine(type)
            hasher.combine(player)
            hasher.combine(hitData)
            hasher.combine(playID)
            hasher.combine(pitchNumber)
        }

        static func == (lhs: PlayEvent, rhs: PlayEvent) -> Bool {
            return lhs.details == rhs.details &&
                lhs.count == rhs.count &&
                lhs.startTime == rhs.startTime &&
                lhs.endTime == rhs.endTime &&
                lhs.type == rhs.type &&
                lhs.player == rhs.player &&
                lhs.hitData == rhs.hitData &&
                lhs.playID == rhs.playID &&
                lhs.pitchNumber == rhs.pitchNumber
        }
    }

    // MARK: - Details

    struct Details: Codable, Hashable {
        let description: String
        let event, eventType: String?
        let awayScore, homeScore: Int?
        let isScoringPlay: Bool?
        let isOut: Bool
        let call: PitchHand?
        let isInPlay, isStrike, isBall: Bool?
        let type: PitchHand?

        func hash(into hasher: inout Hasher) {
            hasher.combine(description)
            hasher.combine(event)
            hasher.combine(eventType)
            hasher.combine(awayScore)
            hasher.combine(homeScore)
            hasher.combine(isScoringPlay)
            hasher.combine(isOut)
            hasher.combine(call)
            hasher.combine(isInPlay)
            hasher.combine(isStrike)
            hasher.combine(isBall)
            hasher.combine(type)
        }

        static func == (lhs: Details, rhs: Details) -> Bool {
            return lhs.description == rhs.description &&
                lhs.event == rhs.event &&
                lhs.eventType == rhs.eventType &&
                lhs.awayScore == rhs.awayScore &&
                lhs.homeScore == rhs.homeScore &&
                lhs.isScoringPlay == rhs.isScoringPlay &&
                lhs.isOut == rhs.isOut &&
                lhs.call == rhs.call &&
                lhs.isInPlay == rhs.isInPlay &&
                lhs.isStrike == rhs.isStrike &&
                lhs.isBall == rhs.isBall &&
                lhs.type == rhs.type
        }
    }

    // MARK: - HitData

    struct HitData: Codable, Hashable {
        let launchSpeed: Double?
        let launchAngle, totalDistance: Int?
        let trajectory: Trajectory
        let hardness: Hardness
        let location: String?

        func hash(into hasher: inout Hasher) {
            hasher.combine(launchSpeed)
            hasher.combine(launchAngle)
            hasher.combine(totalDistance)
            hasher.combine(trajectory)
            hasher.combine(hardness)
            hasher.combine(location)
        }

        static func == (lhs: HitData, rhs: HitData) -> Bool {
            return lhs.launchSpeed == rhs.launchSpeed &&
                lhs.launchAngle == rhs.launchAngle &&
                lhs.totalDistance == rhs.totalDistance &&
                lhs.trajectory == rhs.trajectory &&
                lhs.hardness == rhs.hardness &&
                lhs.location == rhs.location
        }
    }

    // MARK: - Hardness

    enum Hardness: String, Codable {
        case hard
        case medium
        case soft
    }

    // MARK: - Trajectory

    enum Trajectory: String, Codable {
        case buntGrounder = "bunt_grounder"
        case flyBall = "fly_ball"
        case groundBall = "ground_ball"
        case lineDrive = "line_drive"
        case popup
    }

    // MARK: - Player

    struct Player: Codable, Hashable {
        let id: Int
        let link: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(link)
        }

        static func == (lhs: Player, rhs: Player) -> Bool {
            return lhs.id == rhs.id &&
                lhs.link == rhs.link
        }
    }

    // MARK: - PlayEventType

    enum PlayEventType: String, Codable, Hashable, Equatable {
        case action
        case pickoff
        case pitch
        case stepoff
        case no_pitch
    }

    // MARK: - Result

    struct Result: Codable, Hashable {
        let event, eventType, description: String
        let rbi, awayScore, homeScore: Int
        let isOut: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(event)
            hasher.combine(eventType)
            hasher.combine(description)
            hasher.combine(rbi)
            hasher.combine(awayScore)
            hasher.combine(homeScore)
            hasher.combine(isOut)
        }

        static func == (lhs: Result, rhs: Result) -> Bool {
            return lhs.event == rhs.event &&
                lhs.eventType == rhs.eventType &&
                lhs.description == rhs.description &&
                lhs.rbi == rhs.rbi &&
                lhs.awayScore == rhs.awayScore &&
                lhs.homeScore == rhs.homeScore &&
                lhs.isOut == rhs.isOut
        }
    }

    func getPlayByPlay(forGame pack: Int) async -> PlayByPlay? {
        guard let url = URL(string: "https://statsapi.mlb.com/api/v1/game/\(pack)/playByPlay?fields=allPlays%2Cresult%2Ctype%2Cevent%2CeventType%2Cdescription%2Crbi%2CawayScore%2ChomeScore%2CisOut%2Cabout%2ChalfInning%2CisTopInning%2Cinning%2CstartTime%2CendTime%2CisComplete%2CisScoringPlay%2ChasOut%2CcaptivatingIndex%2Ccount%2Cballs%2Cstrikes%2Couts%2Cmatchup%2Cbatter%2Cid%2CfullName%2Clink%2Cpitcher%2CpitchHand%2Csplits%2CmenOnBase%2Cdetails%2CisScoringEvent%2Cearned%2CteamUnearned%2CplayIndex%2Ccredits%2Cplayer%2CplayEvents%2Ccall%2CisInPlay%2CisStrike%2CisBall%2CplateTime%2Cextension%2ChitData%2ClaunchSpeed%2ClaunchAngle%2CtotalDistance%2Ctrajectory%2Chardness%2Clocation%2CcoordX%2CcoordY%2CplayId%2CpitchNumber%2CplayEndTime")
        else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            return try decoder.decode(PlayByPlay.self, from: data)

        } catch {
//            print(error)
        }

        return nil
    }
}

// MARK: - AllPlaysInBaseball_Previews

struct AllPlaysInBaseball_Previews: PreviewProvider {
    static var previews: some View {
        AllPlaysInBaseball()
    }
}
