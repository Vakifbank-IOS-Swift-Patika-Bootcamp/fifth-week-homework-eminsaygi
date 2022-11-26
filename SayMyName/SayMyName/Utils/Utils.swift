//
//  Utils.swift
//  SayMyName
//
//  Created by Emin Saygı on 26.11.2022.
//

import Foundation

class Utils {
    
    static func formatString(name: String) -> String {
        
        let splitValue = name.split(separator: " ")
        var formatValue = ""
        for i in splitValue {
            formatValue += "\(i)+"
        }
        
        let author = String(formatValue.dropLast())
        
        return author
        
    }
    
    
    
}
