//
//  Quotes.swift
//  SayMyName
//
//  Created by Emin Saygı on 26.11.2022.
//

import Foundation

struct QuoteModel: Codable {
    let quoteID: Int
    let quote, author: String
    let series: Series

    enum CodingKeys: String, CodingKey {
        case quoteID = "quote_id"
        case quote, author, series
    }
}

enum Series: String, Codable {
    case betterCallSaul = "Better Call Saul"
    case breakingBad = "Breaking Bad"
}

