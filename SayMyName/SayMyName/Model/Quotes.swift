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

    enum CodingKeys: String, CodingKey {
        case quoteID = "quote_id"
        case quote, author
    }
}

