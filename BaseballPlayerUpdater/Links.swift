//
//  Links.swift
//  BaseballPlayerUpdater
//
//  Created by Vincent DeAugustine on 4/13/23.
//

import Foundation

enum Links {
    
    
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

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

 
