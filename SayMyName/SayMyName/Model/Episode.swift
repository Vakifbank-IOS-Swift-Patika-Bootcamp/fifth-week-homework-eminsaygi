//
//  Episode.swift
//  SayMyName
//
//  Created by Emin Saygı on 26.11.2022.
//

import Foundation

struct WelcomeElement: Codable {
    let episodeID: Int
    let title, season, airDate: String
    let characters: [String]
    let episode: String
    let series: Series

    enum CodingKeys: String, CodingKey {
        case episodeID = "episode_id"
        case title, season
        case airDate = "air_date"
        case characters, episode, series
    }
}

enum Series: String, Codable {
    case betterCallSaul = "Better Call Saul"
    case breakingBad = "Breaking Bad"
}

typealias Welcome = [WelcomeElement]
