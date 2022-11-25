//
//  Character.swift
//  SayMyName
//
//  Created by Emin Saygı on 25.11.2022.
//

import Foundation


struct Character: Decodable {
    
    let name: String?
    let img: String?
    let status: Status?
    let nickname: String?
    let portrayed: String?
    let birthday: String?
    
    
    
    init (characterData: [String: Any]){
        name = characterData["name"] as? String
        img = characterData["img"] as? String
        status = characterData["status"] as? Status
        nickname = characterData["nickname"] as? String
        portrayed = characterData["portrayed"] as? String
        birthday = characterData["birthday"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String: Any]] else { return [] }
        return charactersData.compactMap { Character(characterData: $0) }
    }
}

enum Status: String, Codable {
    
    case alive = "Alive"
    case deceased = "Deceased"
    case presumedDead = "Presumed dead"
    case unknown = "Unknown"
}

enum Birthday: String, Codable {
    case the07081993 = "07-08-1993"
    case the08111970 = "08-11-1970"
    case the09071958 = "09-07-1958"
    case the09241984 = "09-24-1984"
    case unknown = "Unknown"
}

