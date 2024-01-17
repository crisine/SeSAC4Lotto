//
//  Util.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

import Foundation

struct Util {
    static func changeStringFormat(dateString: String, formatFrom: String, formatTo: String) -> String? {
        let srcDateFormatter = DateFormatter()
        srcDateFormatter.dateFormat = formatFrom
        
        if let date = srcDateFormatter.date(from: dateString) {
            let descDateFormatter = DateFormatter()
            descDateFormatter.locale = Locale(identifier: "ko_KR")
            descDateFormatter.dateFormat = formatTo
            
            let convertedString = descDateFormatter.string(from: date)
            return convertedString
        }
        
        return nil
    }
    
    static func changeISODateStringFormat(isoDateString: String, formatTo: String) -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: isoDateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let formattedDate = outputDateFormatter.string(from: date)
            print(formattedDate)
        } else {
            print("Failed to parse the date.")
            return nil
        }
        return nil
    }
}
