//
//  File.swift
//  SayMyName
//
//  Created by Emin Saygı on 26.11.2022.
//

import Foundation


enum ErrorModel : String,Error {
    case invalidURL = "Bad URL"
    case unableToComplete = "Check your internet connection"
    case invalidResponse = "Invalid Response"
    case invalidData = "The data received from the server was invalid. Please try again!"
    
    
}
