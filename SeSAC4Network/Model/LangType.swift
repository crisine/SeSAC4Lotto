//
//  LangType.swift
//  SeSAC4Network
//
//  Created by Minho on 1/17/24.
//

enum LangType: Int {
    case korean
    case english
    case japanese
    case chinese
    case taiwanese
    case vietnamese
    case indonesian
    case thai
    case deutsch
    case russian
    case espanol
    case italian
    case french

    var key: String {
        switch self {
        case .korean:
            return "ko"
        case .english:
            return "en"
        case .japanese:
            return "ja"
        case .chinese:
            return "zh-CN"
        case .taiwanese:
            return "zh-TW"
        case .vietnamese:
            return "vi"
        case .indonesian:
            return "id"
        case .thai:
            return "th"
        case .deutsch:
            return "de"
        case .russian:
            return "ru"
        case .espanol:
            return "es"
        case .italian:
            return "it"
        case .french:
            return "fr"
        }
    }
}
